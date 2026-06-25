# Tokat Personelim — APK ve Google Play Yayın Rehberi

Bu belge, kurumun **doğrudan dağıtım (APK)** ve **Google Play Store** yayını için ihtiyaç duyduğu adımları özetler.

## Uygulama bilgileri

| Alan | Değer |
|------|--------|
| Uygulama adı | Tokat Personelim |
| Paket adı (applicationId) | `com.tokat.tokatpersonelim` |
| Sürüm (pubspec) | `1.3.4` (build numarası artırılarak güncellenir) |
| API tabanı | `https://e-hizmet.tokat.bel.tr/Innosa.WA.MPR` |
| Bildirim API | `https://e-hizmet.tokat.bel.tr/Innosa.WA.MYI` |

---

## 1. Kuruma iletilecek APK (doğrudan kurulum)

Personel cihazlarına Play Store olmadan kurulum için **release APK** kullanılır.

### Derleme (geliştirici ortamında)

```powershell
cd c:\Innosa_Outsource\tokat_personelim
.\scripts\build_release_android.ps1
```

Veya manuel:

```powershell
flutter pub get
flutter build apk --release --build-name=1.3.4 --build-number=5
```

### APK konumu

```
build\app\outputs\flutter-apk\app-release.apk
```

Kurulum: Cihazda “Bilinmeyen kaynaklardan uygulama yükleme” izni verilip APK açılır.

> **Not:** Play Store dışı dağıtımda da imzalı release APK kullanılmalıdır. İmzalama bilgileri aşağıda.

---

## 2. Google Play için App Bundle (AAB)

Play Console **APK değil, AAB** ister (önerilen format).

```powershell
.\scripts\build_release_android.ps1
```

Veya manuel:

```powershell
flutter build appbundle --release --build-name=1.3.4 --build-number=5
```

### AAB konumu

```
build\app\outputs\bundle\release\app-release.aab
```

Play Console → Uygulama → Sürüm → Üretim / Test → **Yeni sürüm oluştur** → AAB yükleyin.

---

## 3. İmzalama (keystore) — KRİTİK

Google Play’e yüklenen her güncelleme **aynı upload keystore** ile imzalanmalıdır. Keystore kaybedilirse uygulama güncellenemez.

### İlk kez oluşturma

```powershell
.\scripts\create_upload_keystore.ps1
```

Oluşan dosyalar (git’e **eklenmez**):

- `android\app\upload-keystore.jks`
- `android\key.properties`

Varsayılan şifre script çıktısında yazılır; **kurum güvenli kasasında saklanmalı**, üretimde mümkünse değiştirilip `key.properties` güncellenmelidir.

### Yedekleme kontrol listesi

- [ ] `upload-keystore.jks` yedeklendi (şifreli arşiv)
- [ ] `key.properties` içindeki şifreler güvenli kayıt altında
- [ ] Sorumlu birim ve yedek kişi bilgilendirildi

---

## 4. Google Play Console hazırlık listesi

Kurumun Play Console’da tamamlaması gerekenler:

### Hesap ve uygulama

- [ ] [Google Play Console](https://play.google.com/console) geliştirici hesabı (kurumsal)
- [ ] Yeni uygulama oluşturma — paket adı: `com.tokat.tokatpersonelim`
- [ ] Uygulama erişimi: kurum içi / kapalı test / açık (politikaya göre)

### Mağaza girişi (Store listing)

- [ ] Uygulama adı: **Tokat Personelim**
- [ ] Kısa açıklama (max 80 karakter)
- [ ] Tam açıklama
- [ ] Ekran görüntüleri (telefon, min. 2 adet; 16:9 veya 9:16)
- [ ] Yüksek çözünürlüklü ikon 512×512 (mevcut: `assets/icons/tokat_logo.png` üzerinden üretilebilir)
- [ ] Özellik grafiği 1024×500 (isteğe bağlı)
- [ ] İletişim e-postası ve gizlilik politikası URL’si

### Politika ve uyumluluk

- [ ] **Gizlilik politikası** URL (zorunlu — personel verisi, konum, bildirim)
- [ ] Veri güvenliği formu (Play Console “Veri güvenliği”)
- [ ] Hedef kitle ve içerik derecelendirmesi anketi
- [ ] Kurumsal / kamu uygulaması ise gerekli beyanlar

### Teknik

- [ ] İlk sürüm: `app-release.aab` yükleme
- [ ] `versionCode` her yeni yüklemede **artmalı** (ör. 3, 4, 5…)
- [ ] `versionName` kullanıcıya görünen sürüm (ör. 1.3.2)
- [ ] Play App Signing: Google’ın yönettiği imzalama (önerilir; upload key yine sizde kalır)

### İzinler (Play açıklaması gerekebilir)

Uygulama şu izinleri kullanır:

- İnternet
- Konum (ince / kaba)
- Bildirimler (Android 13+)

Mağaza açıklamasında **neden** kullanıldığı belirtilmelidir (PDKS, harita, push bildirim vb.).

### Test kanalları (önerilen sıra)

1. **Dahili test** — IT ekibi (birkaç cihaz)
2. **Kapalı test** — seçilmiş personel grubu
3. **Üretim** — tüm kurum

---

## 5. Firebase ve Google Maps

Canlı yayın öncesi kontrol:

- [ ] `android/app/google-services.json` — **production** Firebase projesi
- [ ] Play Console’da uygulama imza SHA-1 / SHA-256 fingerprint’leri Firebase’e eklenmiş
- [ ] Google Maps API anahtarı kısıtlamaları (paket adı + SHA-1)

SHA fingerprint alma:

```powershell
keytool -list -v -keystore android\app\upload-keystore.jks -alias upload
```

---

## 6. Yeni sürüm çıkarma (güncelleme)

1. `pubspec.yaml` içinde `version: X.Y.Z+N` artırın (`N` = versionCode).
2. `flutter build appbundle --release`
3. Play Console’da yeni sürüm + sürüm notları
4. İnceleme sonrası yayın

---

## 7. Dosya özeti (bu teslimat)

| Dosya | Amaç |
|-------|------|
| `app-release.apk` | Kurum içi doğrudan kurulum |
| `app-release.aab` | Google Play yükleme |
| `upload-keystore.jks` | İmzalama (gizli, yedeklenmeli) |
| `key.properties` | Derleme şifreleri (gizli) |
| `key.properties.example` | Şablon |
| `scripts/create_upload_keystore.ps1` | Keystore oluşturma |

---

## 8. Destek

Teknik sorular için geliştirici ekibi / Innosa iletişim bilgileri kurum içi süreçlere göre doldurulmalıdır.
