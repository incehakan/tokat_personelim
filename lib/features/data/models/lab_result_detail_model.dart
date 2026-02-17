class LabResultDetailModel {
  LabResultDetailModel({
    this.code,
    this.message,
    this.resultDetails,
  });

  String? code;
  String? message;
  List<LabResultDetail>? resultDetails;

  LabResultDetailModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMsg"];
    resultDetails = json["SonucListe"] == null
        ? null
        : List<LabResultDetail>.from(
            json["SonucListe"].map((x) => LabResultDetail.fromJson(x)),
          );
  }
}

class LabResultDetail {
  LabResultDetail({
    this.parametreId,
    this.labTetkikId,
    this.panik,
    this.parametreAdi,
    this.sonuc,
    this.sonucRenkDeger,
    this.onay,
    this.referansAraligi,
  });

  String? parametreId;
  String? labTetkikId;
  String? panik;
  String? parametreAdi;
  String? sonuc;
  String? sonucRenkDeger;
  String? onay;
  String? referansAraligi;

  LabResultDetail.fromJson(Map<String, dynamic> json) {
    parametreId = json["PARAMETRE_ID"];
    labTetkikId = json["LAB_TETKIK_ID"];
    panik = json["PANIK"];
    parametreAdi = json["PARAMETRE_ADI"];
    sonuc = json["SONUC"];
    sonucRenkDeger = json["SONUC_RENK_DEGER"];
    onay = json["ONAY"];
    referansAraligi = json["REFERANS_ARALIGI"];
  }
}
