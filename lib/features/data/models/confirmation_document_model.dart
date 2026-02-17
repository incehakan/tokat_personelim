class ConfirmationDocumentModel {
  ConfirmationDocumentModel({
    this.sonucKod,
    this.sonucMesaj,
    this.data,
  });

  int? sonucKod;
  String? sonucMesaj;
  ConfirmationDocument? data;

  ConfirmationDocumentModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    data = json["Data"] == null ? null : ConfirmationDocument.fromJson(json["Data"]);
  }
}

class ConfirmationDocument {
  ConfirmationDocument({
    this.id,
    this.baslik,
    this.icerik,
    this.belgeKodu,
    this.kayitTarihi,
  });

  double? id;
  String? baslik;
  String? icerik;
  String? belgeKodu;
  DateTime? kayitTarihi;

  ConfirmationDocument.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    baslik = json["BASLIK"];
    icerik = json["ICERIK"];
    belgeKodu = json["BELGE_KODU"];
    kayitTarihi = json["KAYIT_TARIHI"] == null ? null : DateTime.parse(json["KAYIT_TARIHI"]);
  }
}
