class BusRouteModel {
  BusRouteModel({
    required this.routes,
    required this.code,
    required this.message,
  });

  List<BusRoute>? routes;
  double? code;
  String? message;

  BusRouteModel.fromJson(Map<String, dynamic> json) {
    routes = List<BusRoute>.from(json["HatGuzergahPlaniListe"].map((x) => BusRoute.fromJson(x)));
    code = json["SonucKodu"]?.toDouble();
    message = json["SonucMesaj"];
  }
}

class BusRoute {
  BusRoute({
    required this.baslangicTarihi,
    required this.bitisTarihi,
    required this.donusXml,
    required this.gidisXml,
    required this.id,
  });

  String? baslangicTarihi;
  String? bitisTarihi;
  String? donusXml;
  String? gidisXml;
  double? id;

  BusRoute.fromJson(Map<String, dynamic> json) {
    baslangicTarihi = json["BaslangicTarihi"];
    bitisTarihi = json["BitisTarihi"];
    donusXml = json["DonusXml"];
    gidisXml = json["GidisXml"];
    id = json["Id"]?.toDouble();
  }
}
