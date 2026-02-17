class ServiceAcceptanceControlModel {
  ServiceAcceptanceControlModel({
    this.code,
    this.message,
    this.admissionResults,
  });

  String? code;
  String? message;
  List<AcceptanceControlResult>? admissionResults;

  ServiceAcceptanceControlModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
    admissionResults = json["SONUC_LISTE"] == null
        ? null
        : List<AcceptanceControlResult>.from(
            json["SONUC_LISTE"].map((x) => AcceptanceControlResult.fromJson(x)),
          );
  }
}

class AcceptanceControlResult {
  AcceptanceControlResult({
    this.rowError,
    this.rowState,
    this.table,
    this.itemArray,
    this.hasErrors,
  });

  String? rowError;
  int? rowState;
  List<ControlResult>? table;
  List<double>? itemArray;
  bool? hasErrors;

  AcceptanceControlResult.fromJson(Map<String, dynamic> json) {
    rowError = json["RowError"];
    rowState = json["RowState"];
    table = json["Table"] == null ? null : List<ControlResult>.from(json["Table"].map((x) => ControlResult.fromJson(x)));
    itemArray = json["ItemArray"] == null ? null : List<double>.from(json["ItemArray"].map((x) => x ?? 1.0));
    hasErrors = json["HasErrors"];
  }
}

class ControlResult {
  ControlResult({
    this.sonSiraNo,
    this.protokolId,
    this.protokolNo,
  });

  double? sonSiraNo;
  double? protokolId;
  dynamic protokolNo;

  ControlResult.fromJson(Map<String, dynamic> json) {
    sonSiraNo = json["SON_SIRA_NO"];
    protokolId = json["PROTOKOL_ID"];
    protokolNo = json["PROTOKOL_NO"];
  }
}
