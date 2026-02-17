class AccidentReportModel {
  AccidentReportModel({
    this.code,
    this.message,
    this.reports,
  });

  int? code;
  String? message;
  List<AccidentReport>? reports;

  AccidentReportModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    reports = json["Data"] == null ? null : List<AccidentReport>.from(json["Data"].map((x) => AccidentReport.fromJson(x)));
  }
}

class AccidentReport {
  AccidentReport({
    this.aciklama,
    this.adiSoyadi,
    this.birimAdi,
    this.birimId,
    this.dahili,
    this.fiiliGorevi,
    this.id,
    this.kadroGorevi,
    this.prsSicilId,
    this.olayTarihi,
    this.olayYeri,
  });

  String? aciklama;
  String? adiSoyadi;
  String? birimAdi;
  double? birimId;
  String? dahili;
  String? fiiliGorevi;
  double? id;
  String? kadroGorevi;
  double? prsSicilId;
  DateTime? olayTarihi;
  String? olayYeri;

  AccidentReport.fromJson(Map<String, dynamic> json) {
    aciklama = json["ACIKLAMA"];
    adiSoyadi = json["ADI_SOYADI"];
    birimAdi = json["BIRIM_ADI"];
    birimId = json["BIRIM_ID"];
    dahili = json["DAHILI"];
    fiiliGorevi = json["FIILI_GOREVI"];
    id = json["ID"];
    kadroGorevi = json["KADRO_GOREVI"];
    prsSicilId = json["PRS_SICIL_ID"];
    olayTarihi = json["OLAY_TARIHI"] == null ? null : DateTime.parse(json["OLAY_TARIHI"]);
    olayYeri = json["OLAY_YERI"];
  }
}
