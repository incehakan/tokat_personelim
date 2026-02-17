class BirthdayModel {
  BirthdayModel({
    this.code,
    this.message,
    this.birthdays,
  });

  int? code;
  String? message;
  List<Birthday>? birthdays;

  BirthdayModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    birthdays = json["Data"] == null ? null : List<Birthday>.from(json["Data"].map((x) => Birthday.fromJson(x)));
  }
}

class Birthday {
  Birthday({
    this.id,
    this.baslik,
    this.ozet,
    this.resim,
    this.tur,
    this.prsSicilId,
    this.etkinlikBaslangictarih,
    this.etkinlikBitistarih,
    this.etkinlikKaynakDegeri,
    this.etkinlikYerAdi,
    this.begeniSayisi,
    this.alkisSayisi,
    this.begendiMi,
    this.alkisladiMi,
    this.tarih,
  });

  double? id;
  String? baslik;
  String? ozet;
  String? resim;
  int? tur;
  double? prsSicilId;
  DateTime? etkinlikBaslangictarih;
  DateTime? etkinlikBitistarih;
  int? etkinlikKaynakDegeri;
  String? etkinlikYerAdi;
  int? begeniSayisi;
  int? alkisSayisi;
  int? begendiMi;
  int? alkisladiMi;
  DateTime? tarih;

  Birthday.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    baslik = json["baslik"];
    ozet = json["ozet"];
    resim = json["resim"];
    tur = json["tur"];
    prsSicilId = json["prs_sicil_id"];
    etkinlikBaslangictarih = json["etkinlikBaslangictarih"] == null ? null : DateTime.parse(json["etkinlikBaslangictarih"]);
    etkinlikBitistarih = json["etkinlikBitistarih"] == null ? null : DateTime.parse(json["etkinlikBitistarih"]);
    etkinlikKaynakDegeri = json["etkinlikKaynakDegeri"];
    etkinlikYerAdi = json["etkinlikYerAdi"];
    begeniSayisi = json["begeniSayisi"];
    alkisSayisi = json["alkisSayisi"];
    begendiMi = json["begendiMi"];
    alkisladiMi = json["alkisladiMi"];
    tarih = json["tarih"] == null ? null : DateTime.parse(json["tarih"]);
  }
}
