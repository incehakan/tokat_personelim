class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    this.kod,
    this.mesaj,
    this.pkId,
    this.ekran,
  });

  int? kod;
  String? mesaj;
  double? pkId;
  int? ekran;

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    kod = json["Kod"];
    mesaj = json["Mesaj"];
    pkId = json["PkId"];
    ekran = json["Ekran"];
  }
}
