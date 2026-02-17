class MovableResponseModel {
  MovableResponseModel({
    this.sonucKod,
    this.sonucMesaj,
    this.data,
  });

  int? sonucKod;
  String? sonucMesaj;
  MovableResponseData? data;

  MovableResponseModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    data = json["Data"] == null ? null : MovableResponseData.fromJson(json["Data"]);
  }
}

class MovableResponseData {
  MovableResponseData({
    this.pkId,
  });

  double? pkId;

  MovableResponseData.fromJson(Map<String, dynamic> json) {
    pkId = json["PkId"];
  }
}
