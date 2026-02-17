class OtpModel {
  num? code;
  String? message;
  num? pkId;
  num? ekran;

  OtpModel({this.code, this.message, this.pkId, this.ekran});

  OtpModel.fromJson(Map<String, dynamic> json) {
    code = json['Kod'];
    message = json['Mesaj'];
    pkId = json['PkId'];
    ekran = json['Ekran'];
  }
}
