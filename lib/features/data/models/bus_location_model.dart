class BusLocationModel {
  BusLocationModel({
    this.busLocation,
    this.code,
    this.message,
  });

  BusLocation? busLocation;
  double? code;
  String? message;

  BusLocationModel.fromJson(Map<String, dynamic> json) {
    busLocation = json["OtobusKonumu"] == null ? null : BusLocation.fromJson(json["OtobusKonumu"]);
    code = json["SonucKodu"];
    message = json["SonucMesaj"];
  }
}

class BusLocation {
  BusLocation({
    this.boylam,
    this.enlem,
    this.hatNo,
    this.hiz,
    this.kontak,
    this.plakaNo,
    this.rolanti,
    this.sicilNo,
    this.soforAdiSoyadi,
    this.soforTcNo,
    this.tarih,
    this.yon,
  });

  String? boylam;
  String? enlem;
  dynamic hatNo;
  num? hiz;
  num? kontak;
  String? plakaNo;
  num? rolanti;
  dynamic sicilNo;
  dynamic soforAdiSoyadi;
  dynamic soforTcNo;
  String? tarih;
  dynamic yon;

  BusLocation.fromJson(Map<String, dynamic> json) {
    boylam = json["Boylam"];
    enlem = json["Enlem"];
    hatNo = json["HatNo"];
    hiz = json["Hiz"];
    kontak = json["Kontak"];
    plakaNo = json["PlakaNo"];
    rolanti = json["Rolanti"];
    sicilNo = json["SicilNo"];
    soforAdiSoyadi = json["SoforAdiSoyadi"];
    soforTcNo = json["SoforTcNo"];
    tarih = json["Tarih"];
    yon = json["Yon"];
  }
}
