class BirthdayCelebrationModel {
  BirthdayCelebrationModel({
    this.code,
    this.message,
    this.celebrations,
  });

  int? code;
  String? message;
  List<BirthdayCelebration>? celebrations;

  BirthdayCelebrationModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    celebrations = json["Data"] == null
        ? null
        : List<BirthdayCelebration>.from(
            json["Data"].map((x) => BirthdayCelebration.fromJson(x)),
          );
  }
}

class BirthdayCelebration {
  BirthdayCelebration({
    this.adiSoyadi,
    this.etAdiSoyadi,
    this.etGorevYeriAdi,
    this.etGorevYeriId,
    this.etkilesilenSicilId,
    this.gorevYeriAdi,
    this.gorevYeriId,
    this.guncellemeKullaniciId,
    this.guncellemeTarihi,
    this.id,
    this.kayitKullaniciId,
    this.kayitTarihi,
    this.sicilId,
    this.tur,
  });

  String? adiSoyadi;
  String? etAdiSoyadi;
  String? etGorevYeriAdi;
  double? etGorevYeriId;
  double? etkilesilenSicilId;
  String? gorevYeriAdi;
  double? gorevYeriId;
  double? guncellemeKullaniciId;
  DateTime? guncellemeTarihi;
  double? id;
  double? kayitKullaniciId;
  DateTime? kayitTarihi;
  double? sicilId;
  int? tur;

  BirthdayCelebration.fromJson(Map<String, dynamic> json) {
    adiSoyadi = json["ADI_SOYADI"];
    etAdiSoyadi = json["ET_ADI_SOYADI"];
    etGorevYeriAdi = json["ET_GOREV_YERI_ADI"];
    etGorevYeriId = json["ET_GOREV_YERI_ID"];
    etkilesilenSicilId = json["ETKILESILEN_SICIL_ID"];
    gorevYeriAdi = json["GOREV_YERI_ADI"];
    gorevYeriId = json["GOREV_YERI_ID"];
    guncellemeKullaniciId = json["GUNCELLEME_KULLANICI_ID"];
    guncellemeTarihi = json["GUNCELLEME_TARIHI"] == null ? null : DateTime.parse(json["GUNCELLEME_TARIHI"]);
    id = json["ID"];
    kayitKullaniciId = json["KAYIT_KULLANICI_ID"];
    kayitTarihi = json["KAYIT_TARIHI"] == null ? null : DateTime.parse(json["KAYIT_TARIHI"]);
    sicilId = json["SICIL_ID"];
    tur = json["TUR"];
  }
}
