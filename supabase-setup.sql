-- Supabase Database Setup for Hproject Promotion Management
-- Bu SQL komutlarını Supabase SQL Editor'de çalıştırın

-- 1. Promotions table (Ana promosyon bilgileri)
CREATE TABLE IF NOT EXISTS promotions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    promo_id TEXT UNIQUE NOT NULL, -- hos-geldin, bonus-buy, etc.
    title TEXT NOT NULL,
    short_desc TEXT,
    description TEXT,
    keywords TEXT[],
    basic_info JSONB DEFAULT '{}',
    sections JSONB DEFAULT '[]',
    is_provider BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Quiz Questions table (Quiz soruları)
CREATE TABLE IF NOT EXISTS quiz_questions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    promotion_id UUID REFERENCES promotions(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    options TEXT[] NOT NULL, -- 4 seçenek
    correct_answer INTEGER NOT NULL CHECK (correct_answer >= 0 AND correct_answer <= 3),
    explanation TEXT,
    order_index INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. İndeksler (Performance için)
CREATE INDEX IF NOT EXISTS idx_promotions_promo_id ON promotions(promo_id);
CREATE INDEX IF NOT EXISTS idx_promotions_is_provider ON promotions(is_provider);
CREATE INDEX IF NOT EXISTS idx_quiz_questions_promotion_id ON quiz_questions(promotion_id);
CREATE INDEX IF NOT EXISTS idx_quiz_questions_order ON quiz_questions(promotion_id, order_index);

-- 4. RLS (Row Level Security) politikaları
ALTER TABLE promotions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;

-- 5. Public read access (Herkes okuyabilir)
CREATE POLICY "Public read access" ON promotions
    FOR SELECT USING (true);

CREATE POLICY "Public read access" ON quiz_questions
    FOR SELECT USING (true);

-- 6. Insert/Update/Delete policies (Admin authentication gerektirebilir)
-- Şimdilik herkese izin veriyoruz, sonra authentication ekleyebiliriz
CREATE POLICY "Public insert access" ON promotions
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Public update access" ON promotions
    FOR UPDATE USING (true);

CREATE POLICY "Public delete access" ON promotions
    FOR DELETE USING (true);

CREATE POLICY "Public insert access" ON quiz_questions
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Public update access" ON quiz_questions
    FOR UPDATE USING (true);

CREATE POLICY "Public delete access" ON quiz_questions
    FOR DELETE USING (true);

-- 7. Updated_at trigger (Otomatik güncelleme tarihi)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_promotions_updated_at BEFORE UPDATE
    ON promotions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 8. Sample data insertion (Test verisi)
-- Mevcut JSON dosyalarından birkaç örnek:

INSERT INTO promotions (promo_id, title, short_desc, description, keywords, basic_info, is_provider) VALUES
('hos-geldin', '🎁 %100 Casino Hoş Geldin Bonusu', 'İlk para yatırımınıza özel %100 bonus', 'İlk para yatırımınıza özel olarak %100 Hoş Geldin Bonusu verilmektedir. Maksimum 10.000₺ bonus alabilirsiniz.', 
 ARRAY['hoş geldin', 'casino', 'bonus', 'yatırım'], 
 '{"Minimum Yatırım": "100₺", "Maksimum Bonus": "10.000₺", "Çevrim Şartı": "35x", "Geçerlilik Süresi": "7 gün"}', 
 false),

('bonus-buy', '🎁 Her Ayın 5''i 15''i, 25''i Bonus Buy', '1.500₺ Bonus Buy hediye', 'Her ayın 5''i, 15''i ve 25''inde 2000₺ ve üzeri yatırımlarınıza 1.500₺ Bonus Buy hediye edilir.',
 ARRAY['bonus buy', 'hediye', 'big bass splash'],
 '{"Minimum Yatırım": "2.000₺", "Hediye Bonus Buy": "1.500₺", "Geçerlilik": "24 saat", "Ana Oyun": "Big Bass Splash"}',
 false),

('pragmatic-play', '🎮 Pragmatic Play Turnuvası', 'Pragmatic Play oyunlarında turnuva', 'Pragmatic Play sağlayıcısının oyunlarında düzenlenen özel turnuva etkinliği.',
 ARRAY['pragmatic play', 'turnuva', 'sağlayıcı'],
 '{"Sağlayıcı": "Pragmatic Play", "Turnuva Türü": "Slot Turnuvası"}',
 true);

-- Quiz sorularını ekleyelim (Hoş Geldin bonusu için örnek)
INSERT INTO quiz_questions (promotion_id, question_text, options, correct_answer, explanation, order_index)
SELECT p.id, 'Casino hoş geldin bonusu oranı yüzde kaçtır?', 
       ARRAY['%75', '%100', '%125', '%150'], 
       1, 
       'İlk para yatırımınıza özel %100 Hoş Geldin Bonusu verilmektedir.',
       1
FROM promotions p WHERE p.promo_id = 'hos-geldin';

INSERT INTO quiz_questions (promotion_id, question_text, options, correct_answer, explanation, order_index)
SELECT p.id, 'Maksimum bonus miktarı ne kadardır?', 
       ARRAY['5.000₺', '7.500₺', '10.000₺', '15.000₺'], 
       2, 
       'Maksimum 10.000₺ olacak şekilde yararlanabilirsiniz.',
       2
FROM promotions p WHERE p.promo_id = 'hos-geldin';

INSERT INTO quiz_questions (promotion_id, question_text, options, correct_answer, explanation, order_index)
SELECT p.id, 'Minimum yatırım miktarı ne kadardır?', 
       ARRAY['50₺', '75₺', '100₺', '150₺'], 
       2, 
       'Minimum 100₺ ve üstü yatırımlar için geçerlidir.',
       3
FROM promotions p WHERE p.promo_id = 'hos-geldin';

-- 9. Helpful views (Kullanışlı görünümler)
CREATE OR REPLACE VIEW promotion_summary AS
SELECT 
    p.promo_id,
    p.title,
    p.short_desc,
    p.is_provider,
    p.created_at,
    COUNT(q.id) as question_count
FROM promotions p
LEFT JOIN quiz_questions q ON p.id = q.promotion_id
GROUP BY p.id, p.promo_id, p.title, p.short_desc, p.is_provider, p.created_at
ORDER BY p.created_at DESC;

-- 10. Cleanup function (Temizlik fonksiyonu)
CREATE OR REPLACE FUNCTION cleanup_orphaned_questions()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM quiz_questions 
    WHERE promotion_id NOT IN (SELECT id FROM promotions);
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;