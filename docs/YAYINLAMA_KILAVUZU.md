# Tokat Personelim — Yayınlama Kılavuzu (Android + iOS)

Bu belge, uygulamanın **Google Play** ve **App Store**'da yayınlanması için
gerekli tüm adımları tek yerde toplar.

## Uygulama özeti

| | Android | iOS |
|---|---------|-----|
| Uygulama adı | Tokat Personelim | Tokat Personelim |
| Paket / Bundle ID | `com.tokat.tokatpersonelim` | `com.tokat.tokatpersonelim` |
| Güncel sürüm | 1.3.4 (build 5) | 1.3.4 (build 5) |
| Mağaza dosyası | `.aab` | `.ipa` |
| API | `https://e-hizmet.tokat.bel.tr/Innosa.WA.MYI` | Aynı |

---

## Hızlı başlangıç

### Android (Windows / macOS / Linux)

```powershell
# 1. Keystore yoksa oluştur (yalnızca ilk kez)
.\scripts\create_upload_keystore.ps1

# 2. Release APK + AAB derle
.\scripts\build_release_android.ps1
```

Çıktılar `release/` klasöründe:
- `TokatPersonelim-v1.3.4-release.apk` → kurum içi kurulum
- `TokatPersonelim-v1.3.4-playstore.aab` → Google Play

### iOS (yalnızca macOS — veya bulut derleme)

Mac yoksa: **`docs/IOS_BULUT_DERLEME.md`** dosyasına bakın (Codemagic / GitHub Actions).

```bash
chmod +x scripts/build_release_ios.sh
./scripts/build_release_ios.sh
```

Çıktı: `release/TokatPersonelim-v1.3.4-appstore.ipa`

---

## Teslim paketi içeriği

```
release/
├── TokatPersonelim-v1.3.4-release.apk      # Android kurum içi
├── TokatPersonelim-v1.3.4-playstore.aab    # Google Play
├── TokatPersonelim-v1.3.4-appstore.ipa     # App Store (Mac'te üretilir)
├── SURUM_NOTLARI_v1.3.4.txt
├── PLAY_STORE_YUKLEME.txt
├── APP_STORE_YUKLEME.txt
└── SHA_FINGERPRINTS.txt                    # Firebase / Maps

android/app/upload-keystore.jks              # GİZLİ — yedek zorunlu
android/key.properties                       # GİZLİ — git'e eklenmez

docs/
├── YAYINLAMA_KILAVUZU.md                    # Bu dosya
├── GOOGLE_PLAY_YAYINLAMA.md
└── APP_STORE_YAYINLAMA.md
```

---

## Google Play — özet adımlar

1. [Play Console](https://play.google.com/console) → uygulama oluştur
2. Mağaza listesi + gizlilik politikası URL
3. `TokatPersonelim-v1.3.4-playstore.aab` yükle
4. Veri güvenliği formu + içerik derecelendirmesi
5. Dahili test → kapalı test → üretim

**Detay:** `docs/GOOGLE_PLAY_YAYINLAMA.md`

### Keystore uyarısı

Upload keystore kaybedilirse uygulama **güncellenemez**.
`upload-keystore.jks` ve şifreleri güvenli yedekleyin.

---

## App Store — özet adımlar

1. Apple Developer Program üyeliği
2. [App Store Connect](https://appstoreconnect.apple.com) → uygulama oluştur
3. Mac'te IPA derle ve Transporter ile yükle
4. Ekran görüntüleri + gizlilik politikası
5. TestFlight → incelemeye gönder

**Detay:** `docs/APP_STORE_YAYINLAMA.md`

### iOS önemli notlar

- iOS derlemesi **Windows'ta yapılamaz** — Mac gerekir
- Firebase `GoogleService-Info.plist` Bundle ID'si `com.tokat.tokatpersonelim` olmalı
- Push bildirim için APNs anahtarı Firebase'e yüklenmeli

---

## Mağaza için hazırlanması gereken materyaller

Kurumun hazırlaması gerekenler (geliştirici dışı):

| Materyal | Boyut / format |
|----------|----------------|
| Uygulama ikonu | 512×512 (Play), 1024×1024 (App Store) |
| Ekran görüntüleri | Min. 2–3 telefon görüntüsü |
| Kısa açıklama | Max 80 karakter (Play) |
| Tam açıklama | Türkçe |
| Gizlilik politikası URL | **Zorunlu** (her iki mağaza) |
| Destek e-postası / URL | Zorunlu |
| Test hesabı | App Store incelemesi için |

İkon kaynağı: `assets/icons/tokat_logo_icon.png`

---

## Firebase ve Google Maps

### Android SHA parmak izleri

`release/SHA_FINGERPRINTS.txt` dosyasındaki SHA-1 ve SHA-256 değerlerini:

1. Firebase Console → Proje ayarları → Android uygulaması
2. Google Cloud Console → Maps API key kısıtlamaları

Play App Signing etkinse Play Console'daki **uygulama imzalama** SHA'larını da ekleyin.

### iOS

- APNs authentication key → Firebase Cloud Messaging
- `GoogleService-Info.plist` güncel ve doğru Bundle ID ile

---

## Yeni sürüm çıkarma kontrol listesi

- [ ] `pubspec.yaml` sürümünü artır (`1.3.4+5` → `1.3.5+6`)
- [ ] `release/SURUM_NOTLARI_v*.txt` güncelle
- [ ] Android: `.\scripts\build_release_android.ps1`
- [ ] iOS: `./scripts/build_release_ios.sh` (Mac)
- [ ] Test cihazlarında smoke test
- [ ] Play Console / App Store Connect'e yükle
- [ ] Sürüm notlarını yaz

---

## Android Studio ile derleme (alternatif)

1. Android Studio → **Open** → `android/` klasörü
2. **Build → Generate Signed Bundle / APK**
3. **Android App Bundle** seçin
4. Keystore: `android/app/upload-keystore.jks`
5. Alias: `upload`
6. Şifreler: `android/key.properties` dosyasından

---

## Xcode ile derleme (alternatif)

1. `open ios/Runner.xcworkspace`
2. Scheme: **Runner**, Device: **Any iOS Device**
3. **Product → Archive**
4. **Distribute App → App Store Connect → Upload**

---

## Destek ve iletişim

Teknik sorular için geliştirici ekibi / Innosa iletişim bilgileri
kurum içi süreçlere göre doldurulmalıdır.
