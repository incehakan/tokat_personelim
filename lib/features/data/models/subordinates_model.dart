class SubordinatesModel {
  SubordinatesModel({
    this.code,
    this.message,
    this.subordinates,
  });

  int? code;
  String? message;
  List<Subordinate>? subordinates;

  SubordinatesModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    subordinates = json["Data"] == null ? null : List<Subordinate>.from(json["Data"].map((x) => Subordinate.fromJson(x)));
  }
}

class Subordinate {
  Subordinate({
    this.sicilId,
    this.tcKimlikNo,
    this.adiSoyadi,
    this.gorevYeriAdi,
    this.tip,
    this.fotograf,
  });

  double? sicilId;
  double? tcKimlikNo;
  String? adiSoyadi;
  String? gorevYeriAdi;
  double? tip;
  String? fotograf;

  Subordinate.fromJson(Map<String, dynamic> json) {
    sicilId = json["SICIL_ID"];
    tcKimlikNo = json["TC_KIMLIK_NO"];
    adiSoyadi = json["ADI_SOYADI"];
    gorevYeriAdi = json["GOREV_YERI_ADI"];
    tip = json["TIP"];
    fotograf = json["FOTOGRAF"];
  }
}
