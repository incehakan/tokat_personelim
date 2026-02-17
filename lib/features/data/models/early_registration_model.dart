class EarlyRegistrationModel {
  EarlyRegistrationModel({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  EarlyRegistrationModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
  }
}
