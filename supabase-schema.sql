-- Promosyonlar tablosu
CREATE TABLE promotions (
    id VARCHAR(100) PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    shortDesc TEXT,
    longDesc TEXT,
    category VARCHAR(50) DEFAULT 'genel',
    status VARCHAR(20) DEFAULT 'active',
    keywords TEXT[],
    basicInfo JSONB,
    sections JSONB,
    quiz JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Quiz sonuçları tablosu
CREATE TABLE quiz_results (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(100),
    user_name VARCHAR(200),
    promotion_id VARCHAR(100) REFERENCES promotions(id),
    quiz_type VARCHAR(50), -- 'new' veya 'old'
    question_count INTEGER,
    correct_answers INTEGER,
    score DECIMAL(5,2),
    time_spent INTEGER, -- saniye cinsinden
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- User performans tablosu (canlı destek ajanları için)
CREATE TABLE user_performance (
    user_id VARCHAR(100) PRIMARY KEY,
    user_name VARCHAR(200),
    total_quizzes INTEGER DEFAULT 0,
    total_score DECIMAL(8,2) DEFAULT 0,
    average_score DECIMAL(5,2) DEFAULT 0,
    favorite_categories TEXT[],
    last_activity TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Promosyon istatistikleri tablosu
CREATE TABLE promotion_stats (
    promotion_id VARCHAR(100) PRIMARY KEY REFERENCES promotions(id),
    total_quiz_attempts INTEGER DEFAULT 0,
    average_score DECIMAL(5,2) DEFAULT 0,
    difficulty_rating DECIMAL(3,2) DEFAULT 0,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Günlük aktivite tablosu
CREATE TABLE daily_activity (
    date DATE PRIMARY KEY,
    total_users INTEGER DEFAULT 0,
    total_quizzes INTEGER DEFAULT 0,
    average_score DECIMAL(5,2) DEFAULT 0,
    most_popular_promotion VARCHAR(100)
);

-- İndeksler
CREATE INDEX idx_quiz_results_user_id ON quiz_results(user_id);
CREATE INDEX idx_quiz_results_promotion_id ON quiz_results(promotion_id);
CREATE INDEX idx_quiz_results_completed_at ON quiz_results(completed_at);
CREATE INDEX idx_promotions_category ON promotions(category);
CREATE INDEX idx_promotions_status ON promotions(status);

-- RLS (Row Level Security) politikaları
ALTER TABLE promotions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_results ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_performance ENABLE ROW LEVEL SECURITY;
ALTER TABLE promotion_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_activity ENABLE ROW LEVEL SECURITY;

-- Herkese okuma izni
CREATE POLICY "Enable read access for all users" ON promotions FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON quiz_results FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON user_performance FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON promotion_stats FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON daily_activity FOR SELECT USING (true);

-- Yazma izinleri (daha sonra özelleştirilebilir)
CREATE POLICY "Enable insert for all users" ON promotions FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update for all users" ON promotions FOR UPDATE USING (true);
CREATE POLICY "Enable delete for all users" ON promotions FOR DELETE USING (true);

CREATE POLICY "Enable insert for all users" ON quiz_results FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable insert for all users" ON user_performance FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update for all users" ON user_performance FOR UPDATE USING (true);

CREATE POLICY "Enable insert for all users" ON promotion_stats FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update for all users" ON promotion_stats FOR UPDATE USING (true);

CREATE POLICY "Enable insert for all users" ON daily_activity FOR INSERT WITH CHECK (true);
CREATE POLICY "Enable update for all users" ON daily_activity FOR UPDATE USING (true);

-- Tetikleyiciler (updated_at alanını otomatik güncelleme)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_promotions_updated_at BEFORE UPDATE ON promotions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Örnek veri ekleme
INSERT INTO promotions (id, title, shortDesc, category, basicInfo) VALUES 
('sample-promo', 'Örnek Promosyon', 'Bu bir örnek promosyondur.', 'casino', 
 '{"Minimum Yatırım": "100₺", "Maksimum Bonus": "1000₺", "Çevrim Şartı": "35x"}');

-- Fonksiyonlar
CREATE OR REPLACE FUNCTION get_user_quiz_stats(user_id_param VARCHAR)
RETURNS TABLE(
    total_quizzes BIGINT,
    avg_score DECIMAL,
    last_quiz_date TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(*) as total_quizzes,
        AVG(score) as avg_score,
        MAX(completed_at) as last_quiz_date
    FROM quiz_results 
    WHERE user_id = user_id_param;
END;
$$ LANGUAGE plpgsql;