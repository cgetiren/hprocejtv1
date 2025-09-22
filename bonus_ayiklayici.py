from bs4 import BeautifulSoup
import re
import os

def promosyonlari_ayikla_ve_grupla(giris_dosyasi_yolu, cikis_dosyasi_yolu):
    """
    HTML dosyasından promosyon başlıklarını (<b> etiketli) ve ilgili <details>
    bloklarını gruplayarak yeni bir HTML dosyası oluşturur.
    """
    try:
        # 1. Giriş dosyasını okuma
        with open(giris_dosyasi_yolu, 'r', encoding='utf-8') as f:
            html_icerik = f.read()
    except FileNotFoundError:
        print(f"HATA: Giriş dosyası bulunamadı: {giris_dosyasi_yolu}")
        return

    # 2. BeautifulSoup ile HTML'i ayrıştırma
    soup = BeautifulSoup(html_icerik, 'html.parser')

    # 3. Ayıklanan promosyonları saklamak için bir liste
    gruplanmis_promosyonlar = []

    # 4. Promosyon başlıklarını (<b> etiketi) bulma
    # Her bir <b> etiketi yeni bir promosyonun başlangıcını işaret ediyor.
    basliklar = soup.find_all('b')

    for baslik in basliklar:
        # Başlığın metnini al
        baslik_metni = baslik.get_text(strip=True)
        if not baslik_metni:
            continue

        # İlgili içeriği toplamak için liste
        icerikler = []
        
        # Başlığın hemen sonrasındaki kardeş elementleri (sibling) gezme
        mevcut_element = baslik.next_sibling
        while mevcut_element:
            # <details> etiketini bul ve içeriği ekle
            if mevcut_element.name == 'details':
                icerikler.append(str(mevcut_element))
            # Yeni bir <b> etiketi bulursak, bu yeni bir promosyon demektir. Döngüyü kır.
            elif mevcut_element.name == 'b':
                break
            
            mevcut_element = mevcut_element.next_sibling
        
        # Eğer başlığın altında ilgili içerik varsa, listeye ekle
        if icerikler:
            gruplanmis_promosyonlar.append({
                'baslik': baslik_metni,
                'icerik': "\n".join(icerikler)
            })

    if not gruplanmis_promosyonlar:
        print("UYARI: Dosya içinde uygun formatta promosyon başlığı ve içeriği bulunamadı.")
        return

    # 5. Yeni HTML dosyasının içeriğini oluşturma
    yeni_html_icerigi = """
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ayıklanmış Promosyonlar (Kategorili)</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; padding: 20px; }
        .promosyon { border: 1px solid #ddd; border-radius: 8px; padding: 20px; margin-bottom: 25px; background-color: #f9f9f9; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .promosyon h2 { color: #0056b3; margin-top: 0; }
        details { border: 1px solid #ccc; border-radius: 4px; padding: 10px; margin-bottom: 15px; background-color: #fff; }
        summary { font-weight: bold; cursor: pointer; color: #333; }
    </style>
</head>
<body>
    <h1>Ayıklanan Promosyon Detayları (Kategorili)</h1>
"""
    # Bulunan tüm promosyon gruplarını ekleme
    for promosyon in gruplanmis_promosyonlar:
        yeni_html_icerigi += f"""
    <div class="promosyon">
        <h2>{promosyon['baslik']}</h2>
        {promosyon['icerik']}
    </div>
"""

    yeni_html_icerigi += """
</body>
</html>
"""
    # 6. Yeni dosyaya yazma
    try:
        with open(cikis_dosyasi_yolu, 'w', encoding='utf-8') as f:
            f.write(yeni_html_icerigi.strip())
        
        print(f"\nBAŞARILI: Promosyonlar başarıyla ayıklandı ve '{cikis_dosyasi_yolu}' dosyasına kaydedildi.")
        print(f"Toplam {len(gruplanmis_promosyonlar)} adet promosyon bloğu ayıklandı.")

    except Exception as e:
        print(f"HATA: Çıkış dosyası yazılırken bir sorun oluştu: {e}")

# --- KULLANIM BÖLÜMÜ ---
# YÜKLEDİĞİNİZ ANA HTML DOSYASININ ADI
GIRIS_DOSYASI = "h11.txt" # Not: h11.txt dosyasında örnek format var.
# OLUŞTURULACAK YENİ DOSYANIN ADI
CIKIS_DOSYASI = "Ayiklanmis_Promosyonlar_Kategorili.html"

# Fonksiyonu çalıştır
promosyonlari_ayikla_ve_grupla(GIRIS_DOSYASI, CIKIS_DOSYASI)