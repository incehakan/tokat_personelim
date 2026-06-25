# iOS İmzasız Teslim — Kaynak Kod Vermeden Kuruma IPA Teslimi

Bu senaryo için:
- Kaynak kod **kuruma verilmez**
- Siz **Apple hesabı / imzalama yapmazsınız**
- Kurum hazır **imzasız IPA** dosyasını kendi Apple Developer hesabıyla imzalar ve yayınlar

---

## Nasıl çalışır?

1. **Siz (Codemagic):** Mac bulutta imzasız `.ipa` üretirsiniz
2. **Kurum (Mac):** IPA'yı kendi sertifikasıyla imzalar → App Store'a yükler

---

## Adım 1 — Codemagic'te imzasız build (Apple hesabı gerekmez)

1. https://codemagic.io → **tokat_personelim** uygulaması
2. **Start new build**
3. Workflow: **Tokat Personelim iOS (Imzasiz)** seçin
   (`tokat-personelim-ios-unsigned`)
4. Branch: `main` → **Start build**

> **Code signing identities ayarlamanıza gerek yok.**

Build bitince **Artifacts**'tan indirin:

```
TokatPersonelim-v1.3.4-unsigned.ipa
```

Bu dosyayı kuruma teslim edersiniz.

---

## Adım 2 — Kuruma teslim edilecekler

| Dosya | Açıklama |
|-------|----------|
| `TokatPersonelim-v1.3.4-unsigned.ipa` | İmzasız uygulama paketi |
| `release/SURUM_NOTLARI_v1.3.4.txt` | Sürüm notları |
| `docs/KURUM_IOS_IMZALAMA.md` | Kurumun imzalama ve yayın kılavuzu |
| `release/KURUM_IOS_TESLIM.txt` | Kurum için özet |

**Teslim etmeyin:** kaynak kod, GitHub erişimi, `lib/`, `ios/` kaynak dosyaları

---

## Adım 3 — codemagic.yaml GitHub'da güncel mi?

Yeni workflow'u push edin:

```powershell
git add codemagic.yaml docs/
git commit -m "iOS imzasiz teslim workflow"
git push origin main
```

Sonra Codemagic'te build başlatın.

---

## Sık sorulan sorular

**Kaynak kod olmadan App Store'a yüklenebilir mi?**
Evet. Kurum imzasız IPA'yı kendi dağıtım sertifikası ile yeniden imzalar.

**Bundle ID değiştirilebilir mi?**
Evet, kurum imzalama sırasında kendi Bundle ID'sini kullanabilir (`com.tokat.tokatpersonelim` veya kurumun seçtiği ID).

**Firebase / push bildirimleri?**
Kurum kendi Firebase projesinde iOS uygulaması oluşturmalı. İmzasız IPA içinde eski Firebase yapılandırması olabilir; kurum gerekirse güncelleme için sizden yeni build isteyebilir (yine kaynak kod vermeden).

**Her güncelleme için ne yapılır?**
Siz yeni imzasız IPA üretirsiniz → kuruma iletirsiniz → kurum imzalar ve yükler.

---

Kurum tarafı detay: `docs/KURUM_IOS_IMZALAMA.md`
