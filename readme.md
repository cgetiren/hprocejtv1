# 🚀 Hproject Promosyon Eğitimi - Modüler Sistem

Modern, interaktif ve kullanıcı dostu bir promosyon eğitim platformu. Bu proje, çeşitli promosyon kampanyalarını eğitici bir şekilde sunmak ve kullanıcıların bilgilerini test etmek için tasarlanmıştır.

[![Netlify Status](https://api.netlify.com/api/v1/badges/your-badge-id/deploy-status)](https://app.netlify.com/sites/your-site-name/deploys)
[![GitHub License](https://img.shields.io/github/license/cgetiren/hproject-egitim)](https://github.com/cgetiren/hproject-egitim/blob/main/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/cgetiren/hproject-egitim?style=social)](https://github.com/cgetiren/hproject-egitim)

## 📋 İçindekiler

- [✨ Özellikler](#-özellikler)
- [📁 Proje Yapısı](#-proje-yapısı)
- [🚀 Kurulum ve Kullanım](#-kurulum-ve-kullanım)
- [📊 Mevcut Promosyonlar](#-mevcut-promosyonlar)
- [🔧 JSON Dosya Yapısı](#-json-dosya-yapısı)
- [🎨 Özelleştirme](#-özelleştirme)
- [🐛 Sorun Giderme](#-sorun-giderme)
- [🌐 Tarayıcı Desteği](#-tarayıcı-desteği)
- [🤝 Katkıda Bulunma](#-katkıda-bulunma)
- [📄 Lisans](#-lisans)
- [👨‍💻 Geliştirici](#-geliştirici)
- [📈 Güncellemeler](#-güncellemeler)

## ✨ Özellikler

### 🎮 Ana Özellikler
- **🎯 Modüler Yapı**: Her promosyon ayrı JSON dosyasında saklanır
- **📱 Akordeon Tasarım**: İçerik alanını optimize eden katlanabilir menüler
- **🧠 İnteraktif Quiz Sistemi**: Her promosyon için 5 farklı soru
- **🔍 Arama Fonksiyonu**: Promosyonları hızlıca bulma
- **📱 Responsive Tasarım**: Tüm cihazlarda mükemmel görünüm
- **✏️ Inline Düzenleme**: Promosyonları doğrudan web arayüzünden düzenleme
- **🎨 Modern UI/UX**: Gradient renkler ve smooth animasyonlar

### 🛠️ Yönetim Özellikleri
- **➕ Promosyon Ekleme**: Yeni promosyonlar kolayca eklenebilir
- **✏️ Promosyon Düzenleme**: Mevcut promosyonlar güncellenebilir
- **🗑️ Promosyon Silme**: Gereksiz promosyonlar kaldırılabilir
- **❓ Quiz Yönetimi**: Her promosyon için özel sorular
- **📊 İstatistikler**: Quiz sonuçları ve kullanım verileri

### 🔧 Teknik Özellikler
- **📦 Vanilla JavaScript**: Framework bağımlılığı yok
- **🎨 Pure CSS**: Modern CSS3 özellikleri
- **📱 Mobile-First**: Responsive tasarım
- **⚡ Hızlı Yükleme**: Optimize edilmiş kod
- **🔒 Güvenli**: XSS koruması ve input validation

## 📁 Proje Yapısı

```
hproject-egitim/
├── hproject-promosyon-egitimi-moduler.html    # Ana uygulama dosyası
├── promosyonlar/                              # Promosyon verileri
│   ├── pragmatic-play.json                   # Pragmatic Play Drops & Wins
│   ├── ertesi-gun.json                       # %35 Ertesi Gün Bonusu
│   ├── bonus-buy.json                        # Her Ayın 5'i 15'i 25'i Bonus Buy
│   ├── hos-geldin.json                       # %100 Casino Hoş Geldin
│   ├── spor-freebet.json                     # %10 Spor Freebet
│   ├── casino-kayip-bonusu.json              # %25 Casino Kayıp Bonusu
│   └── freespin-600.json                     # 600 Freespin Fırsatı
├── assets/                                    # Statik dosyalar (isteğe bağlı)
│   ├── images/                               # Görseller
│   └── icons/                                # İkonlar
├── README.md                                 # Bu dosya
└── LICENSE                                   # Lisans dosyası
```

## 🚀 Kurulum ve Kullanım

### 📋 Gereksinimler
- Modern web tarayıcısı (Chrome 60+, Firefox 55+, Safari 12+, Edge 79+)
- Web sunucusu (yerel geliştirme için)
- Git (versiyon kontrolü için)

### 🏠 Yerel Geliştirme

1. **Repository'yi klonlayın:**
```bash
git clone https://github.com/cgetiren/hproject-egitim.git
cd hproject-egitim
```

2. **Web sunucusunda çalıştırın:**
```bash
# Python ile
python -m http.server 8000

# Node.js ile
npx serve .

# PHP ile
php -S localhost:8000

# Live Server (VS Code Extension) ile
# Dosyaya sağ tıklayıp "Open with Live Server" seçin
```

3. **Tarayıcıda açın:**
```
http://localhost:8000
```

### 🐳 Docker ile Çalıştırma

```dockerfile
# Dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

```bash
# Docker image oluştur
docker build -t hproject-egitim .

# Container çalıştır
docker run -p 8080:80 hproject-egitim
```

## 📊 Mevcut Promosyonlar

| Promosyon | Açıklama | Quiz Soruları | Durum |
|-----------|----------|---------------|-------|
| 🎰 Pragmatic Play Drops & Wins 2025 | Büyük ödül havuzu ve günlük turnuvalar | 5 soru | ✅ Aktif |
| 🎯 %35 Ertesi Gün Bonusu | Günlük kazanç sınırı olmayan bonus | 5 soru | ✅ Aktif |
| 💰 Her Ayın 5'i 15'i 25'i Bonus Buy | Slot oyunlarında bonus satın alma | 5 soru | ✅ Aktif |
| 🎉 %100 Casino Hoş Geldin | Yeni üyelere özel hoş geldin bonusu | 5 soru | ✅ Aktif |
| ⚽ %10 Spor Freebet | Spor bahislerinde ücretsiz bahis | 5 soru | ✅ Aktif |
| 🎲 %25 Casino Kayıp Bonusu | Kayıplarınızı telafi eden bonus | 5 soru | ✅ Aktif |
| 🎰 600 Freespin Fırsatı | Gates Of Olympus ve Sweet Bonanza freespinleri | 5 soru | ✅ Aktif |

## 🔧 JSON Dosya Yapısı

Her promosyon dosyası şu yapıya sahiptir:

```json
{
  "id": "promo-id",
  "title": "Promosyon Başlığı",
  "shortDesc": "Kısa açıklama",
  "description": "Detaylı açıklama",
  "keywords": ["anahtar", "kelimeler"],
  "basicInfo": {
    "key1": "value1",
    "key2": "value2"
  },
  "sections": [
    {
      "title": "Bölüm Başlığı",
      "content": "Bölüm içeriği",
      "items": ["madde1", "madde2"]
    }
  ],
  "quiz": [
    {
      "question": "Soru metni",
      "options": ["A) Seçenek1", "B) Seçenek2", "C) Seçenek3", "D) Seçenek4"],
      "correct": 0,
      "explanation": "Doğru cevap açıklaması"
    }
  ]
}
```

### 📝 JSON Alan Açıklamaları

| Alan | Tip | Açıklama | Zorunlu |
|------|-----|----------|---------|
| `id` | String | Benzersiz promosyon kimliği | ✅ |
| `title` | String | Promosyon başlığı | ✅ |
| `shortDesc` | String | Kısa açıklama (1-2 cümle) | ✅ |
| `description` | String | Detaylı açıklama | ✅ |
| `keywords` | Array | Arama anahtar kelimeleri | ✅ |
| `basicInfo` | Object | Temel bilgiler (key-value) | ❌ |
| `sections` | Array | Detaylı bölümler | ❌ |
| `quiz` | Array | Quiz soruları (5 adet) | ✅ |

## 🎨 Özelleştirme

### ➕ Yeni Promosyon Ekleme

1. **JSON dosyası oluşturun:**
```bash
# promosyonlar/ klasöründe
touch yeni-promosyon.json
```

2. **JSON yapısını doldurun:**
```json
{
  "id": "yeni-promosyon",
  "title": "Yeni Promosyon",
  "shortDesc": "Kısa açıklama",
  "description": "Detaylı açıklama",
  "keywords": ["yeni", "promosyon"],
  "basicInfo": {
    "Başlangıç": "1 Ocak 2024",
    "Bitiş": "31 Aralık 2024"
  },
  "sections": [
    {
      "title": "Şartlar ve Koşullar",
      "content": "Detaylı şartlar...",
      "items": ["Madde 1", "Madde 2"]
    }
  ],
  "quiz": [
    {
      "question": "Yeni promosyon ne zaman başlıyor?",
      "options": ["A) 1 Ocak", "B) 1 Şubat", "C) 1 Mart", "D) 1 Nisan"],
      "correct": 0,
      "explanation": "Yeni promosyon 1 Ocak 2024 tarihinde başlıyor."
    }
  ]
}
```

3. **Uygulama otomatik olarak yeni promosyonu yükleyecektir**

### 🎨 Stil Değişiklikleri

Ana HTML dosyasındaki `<style>` bölümünden CSS stillerini düzenleyebilirsiniz:

```css
/* Ana renkler */
:root {
  --primary-color: #667eea;
  --secondary-color: #764ba2;
  --accent-color: #ff6b6b;
  --text-color: #333;
  --bg-color: #f8f9fa;
}

/* Font değişiklikleri */
body {
  font-family: 'Roboto', 'Segoe UI', sans-serif;
}

/* Boyut değişiklikleri */
.header h1 {
  font-size: 2.5rem;
}
```

### 🔧 JavaScript Özelleştirmeleri

```javascript
// Yeni özellik ekleme
function yeniOzellik() {
  console.log('Yeni özellik çalışıyor!');
}

// Event listener ekleme
document.addEventListener('DOMContentLoaded', function() {
  // Sayfa yüklendiğinde çalışacak kod
});
```

## 🐛 Sorun Giderme

### ❌ Netlify "Broken Link" Hatası

**Sorun**: JSON dosyaları yüklenemiyor
**Çözüm**:
1. JSON dosyalarının `promosyonlar/` klasöründe olduğundan emin olun
2. Dosya adlarının doğru olduğunu kontrol edin
3. Netlify build loglarını inceleyin
4. Browser Developer Tools > Network sekmesinde 404 hatalarını kontrol edin

### ❌ Quiz Çalışmıyor

**Sorun**: Quiz soruları görünmüyor veya çalışmıyor
**Çözüm**:
1. JSON dosyalarında `quiz` array'inin doğru formatta olduğunu kontrol edin
2. Browser console'da JavaScript hatalarını kontrol edin
3. `correct` değerinin 0-3 arasında olduğundan emin olun

### ❌ Responsive Sorunları

**Sorun**: Mobil cihazlarda düzgün görünmüyor
**Çözüm**:
1. CSS media query'lerini kontrol edin
2. Farklı cihazlarda test edin
3. Viewport meta tag'inin doğru olduğundan emin olun

### ❌ Arama Çalışmıyor

**Sorun**: Arama kutusu sonuç vermiyor
**Çözüm**:
1. JavaScript console'da hata var mı kontrol edin
2. `searchPromos()` fonksiyonunun çalıştığından emin olun
3. JSON dosyalarında `keywords` alanının dolu olduğunu kontrol edin

## 🌐 Tarayıcı Desteği

| Tarayıcı | Minimum Versiyon | Durum |
|----------|------------------|-------|
| Chrome | 60+ | ✅ Tam Destek |
| Firefox | 55+ | ✅ Tam Destek |
| Safari | 12+ | ✅ Tam Destek |
| Edge | 79+ | ✅ Tam Destek |
| Opera | 47+ | ✅ Tam Destek |
| Mobile Chrome | 60+ | ✅ Tam Destek |
| Mobile Safari | 12+ | ✅ Tam Destek |

## 🤝 Katkıda Bulunma

Katkıda bulunmak için:

1. **Fork yapın**
2. **Feature branch oluşturun:**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Değişikliklerinizi commit edin:**
   ```bash
   git commit -m 'Add amazing feature'
   ```
4. **Branch'inizi push edin:**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Pull Request oluşturun**

### 📋 Katkı Kuralları

- Kod yazarken mevcut stil rehberini takip edin
- Yeni özellikler için test yazın
- README.md dosyasını güncelleyin
- Commit mesajlarını açıklayıcı yazın

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

```
MIT License

Copyright (c) 2024 Hproject Eğitim Ekibi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 👨‍💻 Geliştirici

- **Proje Yöneticisi**: Can Getiren
- **Frontend Geliştirici**: Can Getiren
- **UI/UX Tasarımcı**: Can Getiren
- **Test Uzmanı**: Can Getiren

## 📈 Güncellemeler

### 🚀 v1.1.2(2025-09-14) - Hproject Rebranding
- ✅ Yeni logo ve renk paleti
- ✅ Geliştirilmiş README.md
- ✅ Docker desteği eklendi
- ✅ Gelişmiş hata yönetimi

### 🎯 v1.1.2 (2025-09-14) - Quiz Sistemi Geliştirmeleri
- ✅ Her promosyon için 5 farklı quiz sorusu
- ✅ Rastgele soru seçimi
- ✅ Gelişmiş feedback sistemi
- ✅ Quiz istatistikleri

### 🎨 v1.0.2 (2025-09-14) - UI/UX Geliştirmeleri
- ✅ Modern gradient tasarım
- ✅ Smooth animasyonlar
- ✅ Gelişmiş responsive tasarım
- ✅ Dark mode desteği (beta)

### 🛠️ v1.0.3 (2025-09-14) - Yönetim Paneli
- ✅ Inline düzenleme sistemi
- ✅ Promosyon ekleme/silme
- ✅ Gelişmiş arama fonksiyonu
- ✅ Bulk operations

### 📱 v1.0.4 (2025-09-14) - Mobile Optimizasyon
- ✅ Mobile-first tasarım
- ✅ Touch-friendly interface
- ✅ Swipe gestures
- ✅ Offline support

### 🎯 v1.0.3 (2025-09-13) - Modüler Sistem
- ✅ JSON tabanlı veri yönetimi
- ✅ Akordeon tasarım
- ✅ Tabbed interface
- ✅ Arama fonksiyonu

### 🚀 v1.0.0 (2025-09-13) - İlk Sürüm
- ✅ Temel promosyon sistemi
- ✅ Quiz sistemi
- ✅ Responsive tasarım
- ✅ Modern UI

## 📊 Proje İstatistikleri

![GitHub stars](https://img.shields.io/github/stars/cgetiren/hproject-egitim?style=social)
![GitHub forks](https://img.shields.io/github/forks/cgetiren/hproject-egitim?style=social)
![GitHub issues](https://img.shields.io/github/issues/cgetiren/hproject-egitim)
![GitHub pull requests](https://img.shields.io/github/issues-pr/cgetiren/hproject-egitim)

## 🎯 Roadmap

### 🔮 Gelecek Özellikler

- [ ] **Multi-language Support**: Çoklu dil desteği
- [ ] **Admin Dashboard**: Gelişmiş yönetim paneli
- [ ] **Analytics**: Detaylı kullanım istatistikleri
- [ ] **API Integration**: REST API desteği
- [ ] **PWA Support**: Progressive Web App
- [ ] **Real-time Updates**: Canlı güncellemeler
- [ ] **User Authentication**: Kullanıcı girişi
- [ ] **Content Management**: İçerik yönetim sistemi

### 🐛 Bilinen Sorunlar

- [ ] iOS Safari'de bazı animasyonlar yavaş
- [ ] Internet Explorer desteği yok
- [ ] Büyük JSON dosyalarında yavaşlık

## 📞 Destek

Sorularınız için:

- 📧 **Email**: [getirencan@gmail.com](mailto:getirencan@hgmail.com)
- 🐛 **Bug Report**: [GitHub Issues](https://github.com/cgetiren/hproject-egitim/issues)

## 🙏 Teşekkürler

Bu projeye katkıda bulunan herkese teşekkürler:

- **Open Source Community**: Açık kaynak topluluğu
- **Contributors**: Projeye katkıda bulunanlar
- **Testers**: Test sürecinde yardımcı olanlar
- **Users**: Geri bildirim veren kullanıcılar

---

**⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!**

**🔗 Projeyi paylaşın**: [https://github.com/cgetiren/hproject-egitim](https://github.com/cgetiren/hproject-egitim)

---

**Not**: Bu proje eğitim amaçlı geliştirilmiştir. Ticari kullanım için gerekli izinleri almayı unutmayın.