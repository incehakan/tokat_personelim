class SubordinatePdksInfoModel {
  SubordinatePdksInfoModel({
    this.code,
    this.message,
    this.pdksInfos,
  });

  int? code;
  String? message;
  List<SubordinatePdksInfo>? pdksInfos;

  SubordinatePdksInfoModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    pdksInfos = json["Data"] == null ? null : List<SubordinatePdksInfo>.from(json["Data"].map((x) => SubordinatePdksInfo.fromJson(x)));
  }
}

class SubordinatePdksInfo {
  SubordinatePdksInfo({
    this.registerId,
    this.nameSurname,
    this.dates,
  });

  double? registerId;
  String? nameSurname;
  List<SubordinatePdksDates>? dates;

  SubordinatePdksInfo.fromJson(Map<String, dynamic> json) {
    registerId = json["SICIL_ID"] ?? json["SICIL_ID"].toDouble();
    nameSurname = json["ADI_SOYADI"];
    dates =
        json["TARIHLER"] == null ? null : List<SubordinatePdksDates>.from(json["TARIHLER"].map((x) => SubordinatePdksDates.fromJson(x)));
  }
}

class SubordinatePdksDates {
  SubordinatePdksDates({
    this.tarih,
    this.details,
  });

  DateTime? tarih;
  List<SubordinatePdksDetails>? details;

  SubordinatePdksDates.fromJson(Map<String, dynamic> json) {
    tarih = json["TARIH"] == null ? null : DateTime.parse(json["TARIH"]);
    details = json["DETAYLAR"] == null
        ? null
        : List<SubordinatePdksDetails>.from(json["DETAYLAR"].map((x) => SubordinatePdksDetails.fromJson(x)));
  }
}

class SubordinatePdksDetails {
  SubordinatePdksDetails({
    this.kolonAdi,
    this.kolonDeger,
    this.basKoordinatX,
    this.basKoordinatY,
    this.bitKoordinatX,
    this.bitKoordinatY,
  });

  String? kolonAdi;
  String? kolonDeger;
  String? basKoordinatX;
  String? basKoordinatY;
  String? bitKoordinatX;
  String? bitKoordinatY;

  SubordinatePdksDetails.fromJson(Map<String, dynamic> json) {
    kolonAdi = json["KOLON_ADI"];
    kolonDeger = json["KOLON_DEGER"];
    basKoordinatX = json["BAS_KOORDINAT_X"];
    basKoordinatY = json["BAS_KOORDINAT_Y"];
    bitKoordinatX = json["BIT_KOORDINAT_X"];
    bitKoordinatY = json["BIT_KOORDINAT_Y"];
  }
}
