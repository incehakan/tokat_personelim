# Kurum teslim paketi — Tokat Personelim v1.3.4

> **Geliştirici imzalama yapmaz (iOS).** Kurum kendi Apple Developer hesabı ile
> kaynak koddan derleyip App Store'a yükler. Detay: `docs/KURUM_TESLIM_REHBERI.md`

## Tek ZIP ile teslim

```powershell
.\scripts\create_delivery_package.ps1
```

Çıktı: `release/TokatPersonelim-v1.3.4-teslim-paketi.zip`

## Teslim edilecek dosyalar

### Android (hazır, imzalı)

1. **`release/TokatPersonelim-v1.3.4-release.apk`** — Kurum içi kurulum
2. **`release/TokatPersonelim-v1.3.4-playstore.aab`** — Google Play yükleme
3. **`release/SHA_FINGERPRINTS.txt`** — Firebase / Maps

### iOS (kaynak kod — kurum imzalar)

4. **GitHub kaynak kodu** — `https://github.com/incehakan/tokat_personelim`
5. **`docs/APP_STORE_YAYINLAMA.md`** — Kurumun Mac'te izleyeceği rehber
6. **`release/APP_STORE_YUKLEME.txt`** — Özet kılavuz

> `.ipa` dosyası geliştirici tarafından teslim edilmez; kurum Xcode ile üretir.

### Dokümantasyon

7. **`release/SURUM_NOTLARI_v1.3.4.txt`**
8. **`release/PLAY_STORE_YUKLEME.txt`**
9. **`release/KURUM_TESLIM_LISTESI.txt`**
10. **`docs/KURUM_TESLIM_REHBERI.md`**
11. **`docs/YAYINLAMA_KILAVUZU.md`**

### Gizli (ayrı güvenli kanal)

12. **`android/app/upload-keystore.jks`**
13. **`android/key.properties`**

## Upload keystore şifre bilgisi

> Bu bilgiyi **güvenli kanaldan** (kurum içi, şifreli) iletin; e-posta ile paylaşmayın.

| Alan | Değer |
|------|--------|
| Dosya | `upload-keystore.jks` |
| Alias | `upload` |
| Store / Key şifre | `key.properties` dosyasında |

İlk Play yayınından önce şifrenin kurum politikasına uygun şekilde değiştirilmesi önerilir.

## Derleme komutları

### Android (Windows)

```powershell
.\scripts\build_release_android.ps1
```

### iOS (macOS)

```bash
./scripts/build_release_ios.sh
```

## Hızlı kurulum (APK)

1. APK dosyasını cihaza aktarın
2. Ayarlar → Güvenlik → Bilinmeyen kaynaklara izin
3. APK'yı açıp kurun

## Mağaza yayını özeti

| Platform | Dosya | Rehber |
|----------|-------|--------|
| Google Play | `.aab` | `docs/GOOGLE_PLAY_YAYINLAMA.md` |
| App Store | `.ipa` | `docs/APP_STORE_YAYINLAMA.md` |

Detay: `docs/YAYINLAMA_KILAVUZU.md`
