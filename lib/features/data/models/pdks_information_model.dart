class PdksInformationModel {
  PdksInformationModel({
    this.code,
    this.message,
    this.informations,
  });

  int? code;
  String? message;
  List<PdksInformation>? informations;

  PdksInformationModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    informations = json["Data"] == null
        ? null
        : List<PdksInformation>.from(
            json["Data"].map((x) => PdksInformation.fromJson(x)),
          );
  }
}

class PdksInformation {
  PdksInformation({
    this.sicilId,
    this.adiSoyadi,
    this.tarihler,
  });

  double? sicilId;
  String? adiSoyadi;
  List<Dates>? tarihler;

  PdksInformation.fromJson(Map<String, dynamic> json) {
    sicilId = json["SICIL_ID"];
    adiSoyadi = json["ADI_SOYADI"];
    tarihler = json["TARIHLER"] == null ? null : List<Dates>.from(json["TARIHLER"].map((x) => Dates.fromJson(x)));
  }
}

class Dates {
  Dates({
    this.tarih,
    this.detaylar,
  });

  DateTime? tarih;
  List<Details>? detaylar;

  Dates.fromJson(Map<String, dynamic> json) {
    tarih = json["TARIH"] == null ? null : DateTime.parse(json["TARIH"]);
    detaylar = json["DETAYLAR"] == null ? null : List<Details>.from(json["DETAYLAR"].map((x) => Details.fromJson(x)));
  }
}

class Details {
  Details({
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

  Details.fromJson(Map<String, dynamic> json) {
    kolonAdi = json["KOLON_ADI"];
    kolonDeger = json["KOLON_DEGER"];
    basKoordinatX = json["BAS_KOORDINAT_X"];
    basKoordinatY = json["BAS_KOORDINAT_Y"];
    bitKoordinatX = json["BIT_KOORDINAT_X"];
    bitKoordinatY = json["BIT_KOORDINAT_Y"];
  }
}
