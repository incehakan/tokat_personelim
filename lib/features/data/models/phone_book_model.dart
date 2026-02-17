class PhoneBookModel {
  PhoneBookModel({
    this.code,
    this.message,
    this.phones,
  });

  int? code;
  String? message;
  List<PhoneBook>? phones;

  PhoneBookModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    phones = json["Data"] == null ? null : List<PhoneBook>.from(json["Data"].map((x) => PhoneBook.fromJson(x)));
  }
}

class PhoneBook {
  PhoneBook({
    this.id,
    this.adiSoyadi,
    this.dahili,
    this.cepTelefonu,
    this.calisilanBirim,
    this.unvanAdi,
    this.servis,
  });

  double? id;
  String? adiSoyadi;
  double? dahili;
  String? cepTelefonu;
  String? calisilanBirim;
  String? unvanAdi;
  String? servis;

  PhoneBook.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    adiSoyadi = json["ADI_SOYADI"];
    dahili = json["DAHILI"];
    cepTelefonu = json["CEP_TELEFONU"];
    calisilanBirim = json["CALISILAN_BIRIM"];
    unvanAdi = json["UNVAN_ADI"];
    servis = json["SERVIS"];
  }
}
