# iOS Bulut Derleme — Mac Olmadan IPA Üretme

Apple, iOS uygulamalarının yalnızca **macOS + Xcode** ile derlenmesine izin verir.
Windows veya Linux'ta yerel `.ipa` üretmek **teknik olarak imkansızdır**.

Çözüm: Kodunuzu bulut Mac sunucusuna gönderip orada derlemek.

---

## Önerilen yöntem: Codemagic (en kolay)

Codemagic, Flutter projeleri için ücretsiz dakika sunar ve imzalama işlemini
web arayüzünden yönetmenizi sağlar.

### Adım 1 — Hesap ve proje bağlama

1. https://codemagic.io adresine gidin
2. GitHub hesabınızla giriş yapın
3. **Add application** → **tokat_personelim** (veya kodunuzu yüklediğiniz) GitHub reposunu seçin
4. Proje tipi: **Flutter**
5. `codemagic.yaml` dosyası otomatik algılanır

### Adım 2 — Apple imzalama ayarı

**Yöntem A — App Store Connect API Key (önerilen)**

1. Codemagic → Team settings → **Integrations** → **Developer Portal**
2. App Store Connect API key ekleyin:
   - https://appstoreconnect.apple.com → Users and Access → Keys
   - Rol: **App Manager** veya **Admin**
   - `.p8` dosyasını indirin
3. Codemagic'e Key ID, Issuer ID ve `.p8` dosyasını girin
4. **Code signing identities** → iOS → Fetch certificate

**Yöntem B — Manuel sertifika**

Apple Developer hesabından:
- Distribution certificate (`.p12`)
- App Store provisioning profile (`.mobileprovision`)

Bu dosyaları Codemagic → Code signing identities bölümüne yükleyin.

### Adım 3 — Firebase (önemli)

`ios/Runner/GoogleService-Info.plist` dosyasındaki Bundle ID şu an eski olabilir.

Firebase Console'da `com.tokat.tokatpersonelim` için iOS uygulaması oluşturup
yeni plist indirin ve repoya commit edin.

### Adım 4 — Derlemeyi başlat

1. Codemagic → uygulamanız → **Start new build**
2. Workflow: `tokat-personelim-ios`
3. Build tamamlanınca **Artifacts** sekmesinden `.ipa` indirin

Çıktı dosya adı:
`TokatPersonelim-v1.3.4-appstore.ipa`

### Adım 5 — App Store'a yükleme

- Mac varsa: **Transporter** uygulamasıyla IPA yükleyin
- Mac yoksa: Codemagic **Publishing** bölümünden doğrudan App Store Connect'e
  yükleme açılabilir (Team settings → Publishing → App Store Connect)

---

## Alternatif: GitHub Actions

Repo'da `.github/workflows/ios-build.yml` dosyası hazır.

### Gereksinimler

GitHub repo → Settings → Secrets and variables → Actions:

| Secret | Açıklama |
|--------|----------|
| `BUILD_CERTIFICATE_BASE64` | Distribution `.p12` dosyasının base64 hali |
| `P12_PASSWORD` | Sertifika şifresi |
| `BUILD_PROVISION_PROFILE_BASE64` | `.mobileprovision` base64 hali |
| `KEYCHAIN_PASSWORD` | Geçici keychain şifresi (rastgele güçlü şifre) |

### Base64 dönüştürme (Windows PowerShell)

```powershell
# .p12 dosyasi
[Convert]::ToBase64String([IO.File]::ReadAllBytes("sertifika.p12")) | Set-Clipboard

# .mobileprovision dosyasi
[Convert]::ToBase64String([IO.File]::ReadAllBytes("profile.mobileprovision")) | Set-Clipboard
```

### Derlemeyi tetikleme

1. GitHub → Actions → **iOS Release Build** → **Run workflow**
2. Veya `main` branch'e push yapın
3. Tamamlanınca **Artifacts** bölümünden IPA indirin

---

## Alternatif: Kiralık bulut Mac

Saatlik ücretli Mac kiralama servisleri:

| Servis | Not |
|--------|-----|
| [MacinCloud](https://www.macincloud.com) | Uzaktan masaüstü Mac |
| [AWS EC2 Mac](https://aws.amazon.com/ec2/instance-types/mac/) | Kurumsal, pahalı |
| [Scaleway Mac mini](https://www.scaleway.com/en/apple-silicon/) | AB lokasyonu |

Kiralık Mac'te:

```bash
git clone https://github.com/KURUMUNUZ/tokat_personelim.git
cd tokat_personelim
chmod +x scripts/build_release_ios.sh
./scripts/build_release_ios.sh
```

---

## Sertifika oluşturma (Apple Developer gerekli)

Apple Developer Program üyeliği olmadan App Store'a yükleyemezsiniz.

1. https://developer.apple.com → Certificates, Identifiers & Profiles
2. **Identifiers** → App ID: `com.tokat.tokatpersonelim`
3. **Certificates** → Apple Distribution sertifikası
4. **Profiles** → App Store provisioning profile
5. Xcode veya Codemagic ile imzalama

---

## Özet karar tablosu

| Yöntem | Mac gerekir mi? | Zorluk | Ücret |
|--------|-----------------|--------|-------|
| **Codemagic** | Hayır | Kolay | Ücretsiz dakika + ücretli plan |
| **GitHub Actions** | Hayır | Orta | 2000 dk/ay ücretsiz (private repo) |
| **Kiralık bulut Mac** | Hayır (uzaktan) | Orta | Saatlik ~$1-5 |
| **Yerel Mac** | Evet | Kolay | Mac satın alma |

**Öneri:** Codemagic ile başlayın — Flutter için en az uğraştıran yöntem.

---

## Sık sorulan sorular

**Windows'ta hiçbir şekilde derlenemez mi?**
Hayır. Apple'ın lisans ve araç kısıtlaması nedeniyle Xcode yalnızca macOS'ta çalışır.

**TestFlight için de Mac gerekir mi?**
Hayır. IPA'yı Codemagic veya Transporter (Mac'te) ile yükleyebilirsiniz.
Codemagic doğrudan App Store Connect'e publish edebilir.

**Simulator için Windows'ta çalışır mı?**
Hayır. iOS simülatör de yalnızca Mac'te çalışır.

---

Detaylı App Store yayın adımları: `docs/APP_STORE_YAYINLAMA.md`
