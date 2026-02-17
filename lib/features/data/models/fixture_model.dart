class FixtureModel {
  FixtureModel({
    this.code,
    this.message,
    this.fixture,
  });

  int? code;
  String? message;
  Fixture? fixture;

  FixtureModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    fixture = Fixture.fromJson(json["Data"]);
  }
}

class Fixture {
  Fixture({
    this.tifDetayId,
    this.ambarId,
    this.kurumId,
    this.kurumsalId,
    this.kurumDemirbasId,
    this.servisId,
    this.tifId,
    this.demirbasNo,
    this.demirbasEkNo,
    this.ambar,
    this.servis,
    this.birim,
    this.malzemeAdi,
    this.zimmetliPersonel,
    this.odaId,
    this.oda,
    this.cihazSeriNo,
    this.cihazKodAdi,
    this.durumu,
    this.garantiBaslamaTarihi,
    this.garantiSuresi,
    this.marka,
    this.saseNo,
  });

  double? tifDetayId;
  double? ambarId;
  double? kurumId;
  double? kurumsalId;
  double? kurumDemirbasId;
  double? servisId;
  double? tifId;
  double? demirbasNo;
  double? demirbasEkNo;
  String? ambar;
  String? servis;
  String? birim;
  String? malzemeAdi;
  String? zimmetliPersonel;
  double? odaId;
  String? oda;
  String? cihazSeriNo;
  String? cihazKodAdi;
  String? durumu;
  DateTime? garantiBaslamaTarihi;
  int? garantiSuresi;
  String? marka;
  String? saseNo;

  Fixture.fromJson(Map<String, dynamic> json) {
    tifDetayId = json["TifDetayId"];
    ambarId = json["AmbarId"];
    kurumId = json["KurumId"];
    kurumsalId = json["KurumsalId"];
    kurumDemirbasId = json["KurumDemirbasId"];
    servisId = json["ServisId"];
    tifId = json["TifId"];
    demirbasNo = json["DemirbasNo"];
    demirbasEkNo = json["DemirbasEkNo"];
    ambar = json["Ambar"];
    servis = json["Servis"];
    birim = json["Birim"];
    malzemeAdi = json["MalzemeAdi"];
    zimmetliPersonel = json["ZimmetliPersonel"];
    odaId = json["OdaId"];
    oda = json["Oda"];
    cihazSeriNo = json["CihazSeriNo"];
    cihazKodAdi = json["CihazKodAdi"];
    durumu = json["Durumu"];
    garantiBaslamaTarihi = DateTime.parse(json["GarantiBaslamaTarihi"]);
    garantiSuresi = json["GarantiSuresi"];
    marka = json["Marka"];
    saseNo = json["SaseNo"];
  }
}
