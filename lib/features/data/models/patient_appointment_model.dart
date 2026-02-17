class PatientAppointmentModel {
  PatientAppointmentModel({
    this.code,
    this.message,
    this.results,
  });

  String? code;
  String? message;
  List<AppointmentResultModel>? results;

  PatientAppointmentModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
    results = json["SONUC_LISTE"] == null
        ? null
        : List<AppointmentResultModel>.from(
            json["SONUC_LISTE"].map((x) => AppointmentResultModel.fromJson(x)),
          );
  }
}

class AppointmentResultModel {
  AppointmentResultModel({
    this.rowError,
    this.rowState,
    this.table,
    this.itemArray,
    this.hasErrors,
  });

  String? rowError;
  int? rowState;
  List<AppointmentResult>? table;
  List<dynamic>? itemArray;
  bool? hasErrors;

  AppointmentResultModel.fromJson(Map<String, dynamic> json) {
    rowError = json["RowError"];
    rowState = json["RowState"];
    table = json["Table"] == null ? null : List<AppointmentResult>.from(json["Table"].map((x) => AppointmentResult.fromJson(x)));
    itemArray = json["ItemArray"] == null ? null : List<dynamic>.from(json["ItemArray"].map((x) => x));
    hasErrors = json["HasErrors"];
  }
}

class AppointmentResult {
  AppointmentResult({
    this.polKodu,
    this.hastaKurumTuru,
    this.anaKurumKodu,
    this.altKurumKodu,
    this.refTarihi,
    this.vakaProtokolNo,
    this.vakaGelisTarihi,
    this.vakaPoliklinikAdi,
    this.vakaDr,
    this.vakaIslemKodu,
    this.vakaGunSayisi,
    this.vakaSonGelisTarihi,
    this.hastaIlkGunFarki,
    this.hastaSonGunFarki,
    this.hastaBulundu,
    this.girisTipi,
  });

  double? polKodu;
  double? hastaKurumTuru;
  double? anaKurumKodu;
  double? altKurumKodu;
  DateTime? refTarihi;
  dynamic vakaProtokolNo;
  DateTime? vakaGelisTarihi;
  dynamic vakaPoliklinikAdi;
  dynamic vakaDr;
  dynamic vakaIslemKodu;
  double? vakaGunSayisi;
  DateTime? vakaSonGelisTarihi;
  double? hastaIlkGunFarki;
  double? hastaSonGunFarki;
  double? hastaBulundu;
  String? girisTipi;

  AppointmentResult.fromJson(Map<String, dynamic> json) {
    polKodu = json["POL_KODU"];
    hastaKurumTuru = json["HASTA_KURUM_TURU"];
    anaKurumKodu = json["ANA_KURUM_KODU"];
    altKurumKodu = json["ALT_KURUM_KODU"];
    refTarihi = json["REF_TARIHI"] == null ? null : DateTime.parse(json["REF_TARIHI"]);
    vakaProtokolNo = json["VAKA_PROTOKOL_NO"];
    vakaGelisTarihi = json["VAKA_GELIS_TARIHI"] == null ? null : DateTime.parse(json["VAKA_GELIS_TARIHI"]);
    vakaPoliklinikAdi = json["VAKA_POLIKLINIK_ADI"];
    vakaDr = json["VAKA_DR"];
    vakaIslemKodu = json["VAKA_ISLEM_KODU"];
    vakaGunSayisi = json["VAKA_GUN_SAYISI"];
    vakaSonGelisTarihi = json["VAKA_SON_GELIS_TARIHI"] == null ? null : DateTime.parse(json["VAKA_SON_GELIS_TARIHI"]);
    hastaIlkGunFarki = json["HASTA_ILK_GUN_FARKI"];
    hastaSonGunFarki = json["HASTA_SON_GUN_FARKI"];
    hastaBulundu = json["HASTA_BULUNDU"];
    girisTipi = json["GIRIS_TIPI"];
  }
}
