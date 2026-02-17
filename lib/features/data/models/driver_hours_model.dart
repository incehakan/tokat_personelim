class DriverHoursModel {
  DriverHoursModel({
    this.adiSoyadi,
    this.duyuru,
    this.seferListe,
    this.sicilNo,
    this.soforDuyuru,
    this.sonucKodu,
    this.sonucMesaj,
  });

  String? adiSoyadi;
  String? duyuru;
  List<DriverHours>? seferListe;
  double? sicilNo;
  String? soforDuyuru;
  double? sonucKodu;
  String? sonucMesaj;

  DriverHoursModel.fromJson(Map<String, dynamic> json) {
    adiSoyadi = json["AdiSoyadi"];
    duyuru = json["Duyuru"];
    seferListe = json["SeferListe"] == null ? null : List<DriverHours>.from(json["SeferListe"].map((x) => DriverHours.fromJson(x)));
    sicilNo = json["SicilNo"];
    soforDuyuru = json["SoforDuyuru"];
    sonucKodu = json["SonucKodu"];
    sonucMesaj = json["SonucMesaj"];
  }
}

class DriverHours {
  DriverHours({
    this.aracId,
    this.bolgeKodu,
    this.degisimYeri,
    this.dilim,
    this.hatAdi,
    this.hatNo,
    this.karsilik1,
    this.karsilik2,
    this.plakaNo,
    this.rumuz,
    this.seferId,
    this.seferSaat,
    this.seferSaatListe,
    this.seferSaatleriId,
    this.sicilNo,
    this.siraNo,
    this.tarih,
  });

  double? aracId;
  double? bolgeKodu;
  String? degisimYeri;
  double? dilim;
  String? hatAdi;
  String? hatNo;
  String? karsilik1;
  String? karsilik2;
  String? plakaNo;
  String? rumuz;
  double? seferId;
  String? seferSaat;
  List<Hours>? seferSaatListe;
  double? seferSaatleriId;
  double? sicilNo;
  double? siraNo;
  dynamic tarih;

  DriverHours.fromJson(Map<String, dynamic> json) {
    aracId = json["AracId"];
    bolgeKodu = json["BolgeKodu"];
    degisimYeri = json["DegisimYeri"];
    dilim = json["Dilim"];
    hatAdi = json["HatAdi"];
    hatNo = json["HatNo"];
    karsilik1 = json["Karsilik1"];
    karsilik2 = json["Karsilik2"];
    plakaNo = json["PlakaNo"];
    rumuz = json["Rumuz"];
    seferId = json["SeferId"];
    seferSaat = json["SeferSaat"];
    seferSaatListe = json["SeferSaatListe"] == null ? null : List<Hours>.from(json["SeferSaatListe"].map((x) => Hours.fromJson(x)));
    seferSaatleriId = json["SeferSaatleriId"];
    sicilNo = json["SicilNo"];
    siraNo = json["SiraNo"];
    tarih = json["Tarih"];
  }
}

class Hours {
  Hours({
    this.donusSaat,
    this.gidisSaat,
  });

  String? donusSaat;
  String? gidisSaat;

  Hours.fromJson(Map<String, dynamic> json) {
    donusSaat = json["DonusSaat"];
    gidisSaat = json["GidisSaat"];
  }
}
