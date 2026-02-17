class KioskModel {
  KioskModel({
    this.code,
    this.message,
    this.kioskList,
  });

  String? code;
  String? message;
  List<KioskList>? kioskList;

  KioskModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
    kioskList = json["SONUC_LISTE"] == null ? null : List<KioskList>.from(json["SONUC_LISTE"].map((x) => KioskList.fromJson(x)));
  }
}

class KioskList {
  KioskList({
    this.rowError,
    this.rowState,
    this.kiosks,
    this.itemArray,
    this.hasErrors,
  });

  String? rowError;
  int? rowState;
  List<Kiosk>? kiosks;
  List<dynamic>? itemArray;
  bool? hasErrors;

  KioskList.fromJson(Map<String, dynamic> json) {
    rowError = json["RowError"];
    rowState = json["RowState"];
    kiosks = json["Table"] == null ? null : List<Kiosk>.from(json["Table"].map((x) => Kiosk.fromJson(x)));
    itemArray = json["ItemArray"] == null ? null : List<dynamic>.from(json["ItemArray"].map((x) => x));
    hasErrors = json["HasErrors"];
  }
}

class Kiosk {
  Kiosk({
    this.servisAdi,
    this.doctorfullname,
    this.doktorUnvan,
    this.doktorAdsoyad,
    this.kioskSira,
    this.servisKodu,
    this.doktorKodu,
    this.kioskAktif,
    this.tarih,
    this.subeKodu,
    this.sskGrupKodu,
  });

  String? servisAdi;
  String? doctorfullname;
  String? doktorUnvan;
  String? doktorAdsoyad;
  double? kioskSira;
  double? servisKodu;
  double? doktorKodu;
  int? kioskAktif;
  DateTime? tarih;
  double? subeKodu;
  double? sskGrupKodu;

  Kiosk.fromJson(Map<String, dynamic> json) {
    servisAdi = json["SERVIS_ADI"];
    doctorfullname = json["DOCTORFULLNAME"];
    doktorUnvan = json["DOKTOR_UNVAN"];
    doktorAdsoyad = json["DOKTOR_ADSOYAD"];
    kioskSira = json["KIOSK_SIRA"];
    servisKodu = json["SERVIS_KODU"];
    doktorKodu = json["DOKTOR_KODU"];
    kioskAktif = json["KIOSK_AKTIF"];
    tarih = json["TARIH"] == null ? null : DateTime.parse(json["TARIH"]);
    subeKodu = json["SUBE_KODU"];
    sskGrupKodu = json["SSK_GRUP_KODU"];
  }
}
