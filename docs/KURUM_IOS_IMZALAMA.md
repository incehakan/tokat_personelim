# Kurum iOS İmzalama ve App Store Yayın Kılavuzu

Bu kılavuz, **kaynak kod olmadan** teslim edilen imzasız IPA dosyasının
kurumunuzun Apple Developer hesabı ile imzalanıp App Store'a yüklenmesi içindir.

---

## Gereksinimler

- Apple Developer Program üyeliği
- macOS bilgisayar
- Xcode (App Store'dan)
- Teslim edilen dosya: `TokatPersonelim-v*-unsigned.ipa`

---

## 1. Apple Developer hazırlığı

1. https://developer.apple.com → **Certificates, Identifiers & Profiles**
2. **Identifiers** → App ID oluşturun
   - Önerilen Bundle ID: `com.tokat.tokatpersonelim`
3. **Certificates** → **Apple Distribution** sertifikası oluşturun
4. **Profiles** → **App Store** provisioning profile oluşturun
5. Sertifikayı Mac'e indirin (.cer → Keychain'e çift tıklayın)

---

## 2. IPA imzalama — Yöntem A: fastlane (önerilen)

### Kurulum

```bash
sudo gem install fastlane
```

### İmzalama

```bash
fastlane run resign \
  ipa:"TokatPersonelim-v1.3.4-unsigned.ipa" \
  signing_identity:"Apple Distribution: Tokat Belediyesi (TEAM_ID)" \
  provisioning_profile:"path/to/TokatPersonelim_AppStore.mobileprovision" \
  output_path:"TokatPersonelim-v1.3.4-signed.ipa"
```

Bundle ID farklı olacaksa:

```bash
fastlane run resign \
  ipa:"TokatPersonelim-v1.3.4-unsigned.ipa" \
  signing_identity:"Apple Distribution: ..." \
  provisioning_profile:"profile.mobileprovision" \
  short_name:"com.tokat.tokatpersonelim" \
  output_path:"TokatPersonelim-v1.3.4-signed.ipa"
```

---

## 3. IPA imzalama — Yöntem B: iResign (grafik arayüz)

1. Mac App Store'dan veya GitHub'dan **iResign** indirin
2. İmzasız IPA dosyasını sürükleyin
3. Distribution sertifikanızı ve provisioning profile'ı seçin
4. **Re-sign** → imzalı IPA kaydedin

---

## 4. App Store Connect'e yükleme

### Transporter ile

1. Mac App Store → **Transporter** uygulamasını indirin
2. İmzalı `.ipa` dosyasını sürükleyin
3. Yükleme tamamlanınca App Store Connect'te işlenmesini bekleyin (5–30 dk)

### Komut satırı

```bash
xcrun altool --upload-app \
  -f TokatPersonelim-v1.3.4-signed.ipa \
  -t ios \
  -u APPLE_ID@email.com \
  -p APP_SPECIFIC_PASSWORD
```

---

## 5. App Store Connect ayarları

1. https://appstoreconnect.apple.com → **My Apps** → yeni uygulama
2. Bundle ID: imzalama sırasında kullandığınız ID
3. Mağaza listesi: açıklama, ekran görüntüleri, gizlilik politikası URL
4. Yüklenen build'i seçin → sürüm notları → **Submit for Review**

---

## 6. Firebase ve bildirimler

Push bildirim çalışması için:

1. Firebase Console → kendi projeniz → iOS uygulaması ekleyin
2. Bundle ID eşleşmeli
3. APNs authentication key yükleyin

> İmzasız IPA içindeki Firebase yapılandırması geliştirici hesabına ait olabilir.
> Kurumsal Firebase projesi kullanılacaksa geliştiriciden yeni IPA build isteyin.

---

## 7. Güncelleme süreci

1. Geliştirici yeni `*-unsigned.ipa` teslim eder
2. Kurum imzalar → App Store Connect'e yükler
3. Yeni sürüm olarak yayınlar

---

## Sorun giderme

| Sorun | Çözüm |
|-------|--------|
| "No signing certificate" | Distribution sertifikası Keychain'de olmalı |
| Bundle ID uyuşmuyor | Provisioning profile Bundle ID ile IPA eşleşmeli |
| Transporter reddediyor | IPA imzalı mı kontrol edin; unsigned yüklenemez |
| Push çalışmıyor | APNs key + doğru Firebase projesi |

---

Teknik destek: geliştirici ekibi ile kurum içi iletişim kanalı üzerinden.
