class LabResultModel {
  LabResultModel({
    this.code,
    this.message,
    this.labResult,
  });

  String? code;
  String? message;
  List<LabResult>? labResult;

  LabResultModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMsg"];
    labResult = json["SonucListe"] == null
        ? null
        : List<LabResult>.from(
            json["SonucListe"].map(
              (x) => LabResult.fromJson(x),
            ),
          );
  }
}

class LabResult {
  LabResult({
    this.protokolNo,
    this.isteyenBirim,
    this.pmGelisTarihi,
  });

  String? protokolNo;
  String? isteyenBirim;
  String? pmGelisTarihi;

  LabResult.fromJson(Map<String, dynamic> json) {
    protokolNo = json["PROTOKOL_NO"];
    isteyenBirim = json["ISTEYEN_BIRIM"];
    pmGelisTarihi = json["PM_GELIS_TARIHI"];
  }
}
