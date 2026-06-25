# Kurum Teslim Rehberi — iOS (Kaynak Kod Vermeden)

## Senaryo

- Kaynak kod **kuruma verilmez**
- Siz **imzalamazsınız** (Apple hesabı gerekmez)
- Kurum **imzasız IPA** alır, kendi hesabıyla imzalar ve App Store'a yükler

---

## Sizin teslim etmeniz gerekenler

| Dosya | Açıklama |
|-------|----------|
| `TokatPersonelim-v1.3.4-unsigned.ipa` | İmzasız uygulama (Codemagic'ten) |
| `release/KURUM_IOS_TESLIM.txt` | Kurum için özet |
| `docs/KURUM_IOS_IMZALAMA.md` | Kurum imzalama kılavuzu |
| `release/SURUM_NOTLARI_v1.3.4.txt` | Sürüm notları |

---

## İmzasız IPA nasıl üretilir?

Codemagic → **Tokat Personelim iOS (Imzasiz)** workflow → build → Artifacts'tan indir.

Detay: `docs/IOS_IMZASIZ_TESLIM.md`

**Apple hesabı veya Code signing ayarı gerekmez.**

---

## Kurumun yapması gerekenler

1. Apple Developer Program
2. Mac + imzalama aracı (fastlane / iResign)
3. IPA imzalama
4. Transporter → App Store Connect
5. Mağaza listesi ve inceleme

Detay: `docs/KURUM_IOS_IMZALAMA.md`

---

## Teslim etmeyin

- GitHub / kaynak kod
- `lib/`, `ios/` proje dosyaları
- Geliştirici Apple sertifikaları
