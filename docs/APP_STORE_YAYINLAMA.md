# Tokat Personelim — App Store Yayın Rehberi

Bu belge iOS / App Store yayını için gereken adımları özetler.

## Uygulama bilgileri

| Alan | Değer |
|------|--------|
| Uygulama adı | Tokat Personelim |
| Bundle ID | `com.tokat.tokatpersonelim` |
| Sürüm (pubspec) | `1.3.4+5` |
| Min. iOS | 14.0 |
| Development Team | `M87N3BV27M` |

---

## 1. Gereksinimler

- **macOS** bilgisayar (iOS derlemesi Windows'ta yapılamaz)
- **Xcode** (App Store'dan)
- **Apple Developer Program** üyeliği (yıllık, kurumsal hesap önerilir)
- **App Store Connect** erişimi
- CocoaPods (`sudo gem install cocoapods`)

---

## 2. İlk kurulum (bir kez)

### 2.1 Apple Developer hesabı

1. [Apple Developer](https://developer.apple.com) → kurumsal hesap
2. **Certificates, Identifiers & Profiles**:
   - App ID: `com.tokat.tokatpersonelim`
   - Capabilities: Push Notifications, Associated Domains (dynamic links kullanılıyorsa)

### 2.2 Xcode imzalama

```bash
open ios/Runner.xcworkspace
```

- **Runner** target → **Signing & Capabilities**
- Team: Tokat Belediyesi (M87N3BV27M)
- Bundle Identifier: `com.tokat.tokatpersonelim`
- **Push Notifications** capability ekli olmalı

### 2.3 Firebase (iOS)

`ios/Runner/GoogleService-Info.plist` dosyasındaki Bundle ID'nin
`com.tokat.tokatpersonelim` ile eşleştiğinden emin olun.

Eşleşmiyorsa Firebase Console'dan yeni iOS uygulaması ekleyip plist'i indirin.

### 2.4 APNs (Push bildirim)

1. Apple Developer → Keys → **Apple Push Notifications service (APNs)** anahtarı oluşturun
2. Firebase Console → Project Settings → Cloud Messaging → APNs key yükleyin

---

## 3. Release derleme

### Otomatik (önerilen)

```bash
cd /path/to/tokat_personelim
chmod +x scripts/build_release_ios.sh
./scripts/build_release_ios.sh
```

Çıktı: `release/TokatPersonelim-v1.3.4-appstore.ipa`

### Manuel (Xcode)

```bash
flutter pub get
cd ios && pod install && cd ..
flutter build ipa --release --export-options-plist=ios/ExportOptions.plist
```

Veya Xcode: **Product → Archive → Distribute App → App Store Connect**

---

## 4. App Store Connect

### 4.1 Uygulama oluşturma

1. [App Store Connect](https://appstoreconnect.apple.com) → **My Apps** → **+**
2. Platform: iOS
3. Name: **Tokat Personelim**
4. Bundle ID: `com.tokat.tokatpersonelim`

### 4.2 Mağaza listesi

| Alan | Açıklama |
|------|----------|
| Açıklama | Personel uygulaması özellikleri |
| Anahtar kelimeler | tokat, belediye, personel, pdks |
| Destek URL'si | Kurum web sitesi |
| Gizlilik politikası URL'si | **Zorunlu** |
| Ekran görüntüleri | iPhone 6.7" (1290×2796) min. 3 adet |
| Uygulama ikonu | 1024×1024 (Xcode asset catalog'dan) |

### 4.3 App Privacy (Veri gizliliği)

Uygulama şu verileri kullanır; formda beyan edin:

- Kimlik bilgisi (TC, kullanıcı adı)
- Konum (PDKS, harita)
- İletişim bilgileri
- Tanımlayıcılar (Firebase push token)

### 4.4 TestFlight

1. IPA yüklendikten sonra build işlenmesini bekleyin
2. **TestFlight** → Internal Testing → test kullanıcıları ekleyin
3. Onay sonrası personel grubuna External Testing açın

### 4.5 İncelemeye gönderme

1. **App Store** sekmesi → yeni sürüm oluşturun
2. Build seçin (1.3.4 / 5)
3. Sürüm notlarını yazın
4. **App Review Information**: test kullanıcı adı/şifresi verin
5. **Submit for Review**

İnceleme süresi genelde 1–3 iş günü.

---

## 5. İzin açıklamaları (Info.plist)

App Store incelemesi için kullanım açıklamaları tanımlıdır:

- Kamera (barkod tarama)
- Konum (PDKS)
- Fotoğraf kütüphanesi
- Bildirimler (arka plan: remote-notification)

---

## 6. Yeni sürüm çıkarma

1. `pubspec.yaml` → `version: X.Y.Z+N` artırın
2. `./scripts/build_release_ios.sh`
3. Transporter veya Xcode ile yükleyin
4. App Store Connect'te yeni sürüm + sürüm notları
5. İncelemeye gönderin

---

## 7. Sorun giderme

| Sorun | Çözüm |
|-------|--------|
| Signing hatası | Xcode → Signing → Team ve Bundle ID kontrol |
| Pod install hatası | `cd ios && pod deintegrate && pod install` |
| Push çalışmıyor | APNs key + production entitlements (`Runner-Release.entitlements`) |
| Firebase hatası | GoogleService-Info.plist Bundle ID eşleşmesi |
| Archive gri | Gerçek cihaz seçili olmalı (simülatör değil) |

---

## 8. Dosya özeti

| Dosya | Amaç |
|-------|------|
| `scripts/build_release_ios.sh` | IPA derleme |
| `ios/ExportOptions.plist` | App Store export ayarları |
| `ios/Runner/Runner-Release.entitlements` | Production push |
| `release/TokatPersonelim-v*-appstore.ipa` | App Store yükleme dosyası |
| `release/APP_STORE_YUKLEME.txt` | Hızlı yükleme özeti |
