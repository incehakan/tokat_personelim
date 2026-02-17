class MovableCountModel {
  MovableCountModel({
    this.sonucKod,
    this.sonucMesaj,
    this.data,
  });

  int? sonucKod;
  String? sonucMesaj;
  MovableCountModelData? data;

  MovableCountModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    data = json["Data"] == null ? null : MovableCountModelData.fromJson(json["Data"]);
  }
}

class MovableCountModelData {
  MovableCountModelData({
    this.ambarId,
    this.id,
    this.ambar,
    this.yil,
    this.detay,
  });

  double? ambarId;
  double? id;
  String? ambar;
  int? yil;
  List<MovableCountDetail>? detay;

  MovableCountModelData.fromJson(Map<String, dynamic> json) {
    ambarId = json["AmbarId"];
    id = json["Id"];
    ambar = json["Ambar"];
    yil = json["Yil"];
    detay = json["Detay"] == null ? null : List<MovableCountDetail>.from(json["Detay"].map((x) => MovableCountDetail.fromJson(x)));
  }
}

class MovableCountDetail {
  MovableCountDetail({
    this.adi,
    this.odaId,
    this.tifDetayId,
    this.sayimId,
    this.aciklama,
    this.id,
    this.demirbasNo,
    this.demirbasNoEk,
    this.tasinirKodlariId,
  });

  String? adi;
  double? odaId;
  double? tifDetayId;
  double? sayimId;
  String? aciklama;
  double? id;
  double? demirbasNo;
  double? demirbasNoEk;
  double? tasinirKodlariId;

  MovableCountDetail.fromJson(Map<String, dynamic> json) {
    adi = json["Adi"];
    odaId = json["OdaId"];
    tifDetayId = json["TifDetayId"];
    sayimId = json["SayimId"];
    aciklama = json["Aciklama"];
    id = json["Id"];
    demirbasNo = json["DemirbasNo"];
    demirbasNoEk = json["DemirbasNoEk"];
    tasinirKodlariId = json["TasinirKodlariId"];
  }
}
