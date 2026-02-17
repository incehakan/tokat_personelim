class ViewResultModel {
  ViewResultModel({
    this.code,
    this.message,
    this.results,
  });

  String? code;
  String? message;
  List<ViewResult>? results;

  ViewResultModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMsg"];
    results = json["SonucListe"] == null
        ? null
        : List<ViewResult>.from(
            json["SonucListe"].map((x) => ViewResult.fromJson(x)),
          );
  }
}

class ViewResult {
  ViewResult({
    this.protokolNo,
    this.labTetkikId,
    this.isteyenBirim,
    this.tetkikAdi,
    this.pmGelisTarihi,
    this.onay,
    this.onayDurum,
    this.pacsAddress,
    this.sonuc,
  });

  String? protokolNo;
  String? labTetkikId;
  String? isteyenBirim;
  String? tetkikAdi;
  String? pmGelisTarihi;
  String? onay;
  String? onayDurum;
  String? pacsAddress;
  String? sonuc;

  ViewResult.fromJson(Map<String, dynamic> json) {
    protokolNo = json["PROTOKOL_NO"];
    labTetkikId = json["LAB_TETKIK_ID"];
    isteyenBirim = json["ISTEYEN_BIRIM"];
    tetkikAdi = json["TETKIK_ADI"];
    pmGelisTarihi = json["PM_GELIS_TARIHI"];
    onay = json["ONAY"];
    onayDurum = json["ONAY_DURUM"];
    pacsAddress = json["PACS_ADDRESS"];
    sonuc = json["SONUC"];
  }
}
