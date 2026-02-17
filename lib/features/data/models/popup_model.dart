class ActivePopUpModel {
  ActivePopUpModel({
    this.sonucKod,
    this.sonucMesaj,
    this.data,
  });

  int? sonucKod;
  String? sonucMesaj;
  ActivePopUp? data;

  ActivePopUpModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    data = json["Data"] == null ? null : ActivePopUp.fromJson(json["Data"]);
  }
}

class ActivePopUp {
  ActivePopUp({
    this.id,
    this.turId,
    this.tur,
    this.icerik,
    this.baslangicTarihi,
    this.bitisTarihi,
  });

  double? id;
  double? turId;
  String? tur;
  String? icerik;
  DateTime? baslangicTarihi;
  DateTime? bitisTarihi;

  ActivePopUp.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    turId = json["TUR_ID"];
    tur = json["TUR"];
    icerik = json["ICERIK"];
    baslangicTarihi = json["BASLANGIC_TARIHI"] == null ? null : DateTime.parse(json["BASLANGIC_TARIHI"]);
    bitisTarihi = json["BITIS_TARIHI"] == null ? null : DateTime.parse(json["BITIS_TARIHI"]);
  }
}
