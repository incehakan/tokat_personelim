class PatientAcceptanceControlModel {
  PatientAcceptanceControlModel({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  PatientAcceptanceControlModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
  }
}
