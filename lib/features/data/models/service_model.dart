class ServiceModel {
  ServiceModel({
    this.sonucKod,
    this.sonucMesaj,
    this.services,
  });

  int? sonucKod;
  String? sonucMesaj;
  List<ServiceData>? services;

  ServiceModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    services = json["Data"] == null ? null : List<ServiceData>.from(json["Data"].map((x) => ServiceData.fromJson(x)));
  }
}

class ServiceData {
  ServiceData({
    this.adi,
    this.id,
  });

  String? adi;
  double? id;

  ServiceData.fromJson(Map<String, dynamic> json) {
    adi = json["ADI"];
    id = json["ID"];
  }
}
