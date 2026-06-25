# Kurum teslim paketi — Tokat Personelim v1.3.4

## Teslim edilecek dosyalar

1. **`release/TokatPersonelim-v1.3.4-release.apk`** — Personel cihazlarına doğrudan kurulum
2. **`release/TokatPersonelim-v1.3.4-playstore.aab`** — Google Play Console yükleme
3. **`release/TokatPersonelim-v1.3.4-appstore.ipa`** — App Store yükleme (Mac'te derlenir)
4. **`release/SURUM_NOTLARI_v1.3.4.txt`** — Sürüm değişiklikleri
5. **`release/PLAY_STORE_YUKLEME.txt`** — Play Console yükleme kılavuzu
6. **`release/APP_STORE_YUKLEME.txt`** — App Store yükleme kılavuzu
7. **`release/SHA_FINGERPRINTS.txt`** — Firebase / Maps SHA parmak izleri
8. **`android/app/upload-keystore.jks`** — Play güncellemeleri için imza dosyası (**gizli**, yedek zorunlu)
9. **`docs/YAYINLAMA_KILAVUZU.md`** — Ana yayınlama kılavuzu
10. **`docs/GOOGLE_PLAY_YAYINLAMA.md`** — Play Store detay rehberi
11. **`docs/APP_STORE_YAYINLAMA.md`** — App Store detay rehberi

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
