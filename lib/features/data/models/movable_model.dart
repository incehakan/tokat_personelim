class MovableModel {
  MovableModel({
    this.sonucKod,
    this.sonucMesaj,
    this.data,
  });

  int? sonucKod;
  String? sonucMesaj;
  List<MovableData>? data;

  MovableModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    data = json["Data"] == null ? null : List<MovableData>.from(json["Data"].map((x) => MovableData.fromJson(x)));
  }
}

class MovableData {
  MovableData({
    this.id,
    this.anaId,
    this.seviye,
    this.seviyeAdi,
    this.sinif1,
    this.sinif2,
    this.sinif3,
    this.sinif4,
    this.sinif5,
    this.sinif6,
    this.sinif7,
    this.sinif8,
    this.sinif9,
    this.hesapTumu,
    this.hesapAciklamaTumu,
    this.adi,
    this.olcuBirimId,
    this.olcuBirimi,
  });

  double? id;
  double? anaId;
  double? seviye;
  String? seviyeAdi;
  int? sinif1;
  int? sinif2;
  int? sinif3;
  int? sinif4;
  int? sinif5;
  int? sinif6;
  int? sinif7;
  int? sinif8;
  int? sinif9;
  String? hesapTumu;
  String? hesapAciklamaTumu;
  String? adi;
  double? olcuBirimId;
  String? olcuBirimi;

  MovableData.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    anaId = json["ANA_ID"];
    seviye = json["SEVIYE"];
    seviyeAdi = json["SEVIYE_ADI"];
    sinif1 = json["SINIF1"];
    sinif2 = json["SINIF2"];
    sinif3 = json["SINIF3"];
    sinif4 = json["SINIF4"];
    sinif5 = json["SINIF5"];
    sinif6 = json["SINIF6"];
    sinif7 = json["SINIF7"];
    sinif8 = json["SINIF8"];
    sinif9 = json["SINIF9"];
    hesapTumu = json["HESAP_TUMU"];
    hesapAciklamaTumu = json["HESAP_ACIKLAMA_TUMU"];
    adi = json["ADI"];
    olcuBirimId = json["OLCU_BIRIM_ID"];
    olcuBirimi = json["OLCU_BIRIMI"];
  }
}
