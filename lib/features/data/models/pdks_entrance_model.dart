class PdksEntranceModel {
  PdksEntranceModel({
    this.sonucKod,
    this.sonucMesaj,
    this.data,
  });

  int? sonucKod;
  String? sonucMesaj;
  Data? data;

  PdksEntranceModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    data = json["Data"] == null ? null : Data.fromJson(json["Data"]);
  }
}

class Data {
  Data({
    this.pkId,
  });

  double? pkId;

  Data.fromJson(Map<String, dynamic> json) {
    pkId = json["PkId"];
  }
}
