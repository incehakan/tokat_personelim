class PathologyResultModel {
  PathologyResultModel({
    this.code,
    this.message,
    this.results,
  });

  String? code;
  String? message;
  List<PathologyResult>? results;

  PathologyResultModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMsg"];
    results = json["SonucListe"] == null
        ? null
        : List<PathologyResult>.from(
            json["SonucListe"].map((x) => PathologyResult.fromJson(x)),
          );
  }
}

class PathologyResult {
  PathologyResult({
    this.protokolNo,
    this.patolojiId,
    this.isteyenBirim,
    this.tetkikAdi,
    this.pmGelisTarihi,
    this.onay,
    this.onayDurum,
  });

  String? protokolNo;
  String? patolojiId;
  String? isteyenBirim;
  String? tetkikAdi;
  String? pmGelisTarihi;
  String? onay;
  String? onayDurum;

  PathologyResult.fromJson(Map<String, dynamic> json) {
    protokolNo = json["PROTOKOL_NO"];
    patolojiId = json["PATOLOJI_ID"];
    isteyenBirim = json["ISTEYEN_BIRIM"];
    tetkikAdi = json["TETKIK_ADI"];
    pmGelisTarihi = json["PM_GELIS_TARIHI"];
    onay = json["ONAY"];
    onayDurum = json["ONAY_DURUM"];
  }
}
