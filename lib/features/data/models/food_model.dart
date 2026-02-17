class FoodModel {
  FoodModel({
    this.code,
    this.message,
    this.datas,
  });

  int? code;
  String? message;
  List<FoodData>? datas;

  FoodModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    datas = json["Data"] == null ? null : List<FoodData>.from(json["Data"].map((x) => FoodData.fromJson(x)));
  }
}

class FoodData {
  FoodData({
    this.ay,
    this.details,
  });

  double? ay;
  List<FoodDataDetail>? details;

  FoodData.fromJson(Map<String, dynamic> json) {
    ay = json["Ay"];
    details = json["Tarihler"] == null ? null : List<FoodDataDetail>.from(json["Tarihler"].map((x) => FoodDataDetail.fromJson(x)));
  }
}

class FoodDataDetail {
  FoodDataDetail({
    this.tarih,
    this.yemekler,
  });

  DateTime? tarih;
  List<Foods>? yemekler;

  FoodDataDetail.fromJson(Map<String, dynamic> json) {
    tarih = json["Tarih"] == null ? null : DateTime.parse(json["Tarih"]);
    yemekler = json["Yemekler"] == null ? null : List<Foods>.from(json["Yemekler"].map((x) => Foods.fromJson(x)));
  }
}

class Foods {
  Foods({
    this.id,
    this.yemek,
    this.tip,
    this.tipAdi,
    this.sra,
  });

  double? id;
  String? yemek;
  double? tip;
  String? tipAdi;
  double? sra;

  Foods.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    yemek = json["Yemek"];
    tip = json["Tip"];
    tipAdi = json["TipAdi"];
    sra = json["Sıra"];
  }
}
