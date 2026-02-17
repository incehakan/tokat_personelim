class PatientInformationModel {
  PatientInformationModel({
    this.code,
    this.message,
    this.patientInformations,
  });

  String? code;
  String? message;
  List<PatientInformations>? patientInformations;

  PatientInformationModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
    patientInformations = json["SONUC_LISTE"] == null
        ? null
        : List<PatientInformations>.from(
            json["SONUC_LISTE"].map(
              (x) => PatientInformations.fromJson(x),
            ),
          );
  }
}

class PatientInformations {
  PatientInformations({
    this.rowError,
    this.rowState,
    this.table,
    this.itemArray,
    this.hasErrors,
  });

  String? rowError;
  int? rowState;
  List<PatientInformation>? table;
  List<dynamic>? itemArray;
  bool? hasErrors;

  PatientInformations.fromJson(Map<String, dynamic> json) {
    rowError = json["RowError"];
    rowState = json["RowState"];
    table = json["Table"] == null ? null : List<PatientInformation>.from(json["Table"].map((x) => PatientInformation.fromJson(x)));
    itemArray = json["ItemArray"] == null ? null : List<dynamic>.from(json["ItemArray"].map((x) => x));
    hasErrors = json["HasErrors"];
  }
}

class PatientInformation {
  PatientInformation({
    this.hastaNo,
    this.adi,
    this.soyadi,
    this.tcKimlikNo,
    this.hastaYakinlikKodu,
    this.anaKurumKodu,
    this.altKurumKodu,
    this.kurumTuru,
    this.kurumTuruAdi,
    this.kurumtip,
    this.vakaYok,
    this.karneSeri,
    this.karneNo,
    this.kurumSicilNo,
    this.tahsisNo,
    this.kioskIlkMuayeneIzni,
    this.kioskKayitIzni,
    this.kioskProvizyonAlinanYer,
    this.kioskVakaIzni,
  });

  String? hastaNo;
  String? adi;
  String? soyadi;
  String? tcKimlikNo;
  dynamic hastaYakinlikKodu;
  int? anaKurumKodu;
  int? altKurumKodu;
  int? kurumTuru;
  String? kurumTuruAdi;
  String? kurumtip;
  int? vakaYok;
  dynamic karneSeri;
  dynamic karneNo;
  String? kurumSicilNo;
  dynamic tahsisNo;
  int? kioskIlkMuayeneIzni;
  int? kioskKayitIzni;
  int? kioskProvizyonAlinanYer;
  int? kioskVakaIzni;

  PatientInformation.fromJson(Map<String, dynamic> json) {
    hastaNo = json["HASTA_NO"];
    adi = json["ADI"];
    soyadi = json["SOYADI"];
    tcKimlikNo = json["TC_KIMLIK_NO"];
    hastaYakinlikKodu = json["HASTA_YAKINLIK_KODU"];
    anaKurumKodu = json["ANA_KURUM_KODU"];
    altKurumKodu = json["ALT_KURUM_KODU"];
    kurumTuru = json["KURUM_TURU"];
    kurumTuruAdi = json["KURUM_TURU_ADI"];
    kurumtip = json["KURUMTIP"];
    vakaYok = json["VAKA_YOK"];
    karneSeri = json["KARNE_SERI"];
    karneNo = json["KARNE_NO"];
    kurumSicilNo = json["KURUM_SICIL_NO"];
    tahsisNo = json["TAHSIS_NO"];
    kioskIlkMuayeneIzni = json["KIOSK_ILK_MUAYENE_IZNI"];
    kioskKayitIzni = json["KIOSK_KAYIT_IZNI"];
    kioskProvizyonAlinanYer = json["KIOSK_PROVIZYON_ALINAN_YER"];
    kioskVakaIzni = json["KIOSK_VAKA_IZNI"];
  }
}
