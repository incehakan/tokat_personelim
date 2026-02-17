class PdksDutyModel {
  PdksDutyModel({
    this.code,
    this.message,
    this.duties,
  });

  int? code;
  String? message;
  List<PdksDuty>? duties;

  PdksDutyModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    duties = List<PdksDuty>.from(json["Data"].map((x) => PdksDuty.fromJson(x)));
  }
}

class PdksDuty {
  PdksDuty({
    this.id,
    this.baslamaTarihi,
    this.bitisTarihi,
    this.basKoordinatX,
    this.basKoordinatY,
    this.bitKoordinatX,
    this.bitKoordinatY,
  });

  double? id;
  DateTime? baslamaTarihi;
  DateTime? bitisTarihi;
  String? basKoordinatX;
  String? basKoordinatY;
  String? bitKoordinatX;
  String? bitKoordinatY;

  PdksDuty.fromJson(Map<String, dynamic> json) {
    id = json["ID"].toDouble();
    baslamaTarihi = DateTime.parse(json["BASLAMA_TARIHI"]);
    bitisTarihi = DateTime.parse(json["BITIS_TARIHI"]);
    basKoordinatX = json["BAS_KOORDINAT_X"];
    basKoordinatY = json["BAS_KOORDINAT_Y"];
    bitKoordinatX = json["BIT_KOORDINAT_X"];
    bitKoordinatY = json["BIT_KOORDINAT_Y"];
  }
}
