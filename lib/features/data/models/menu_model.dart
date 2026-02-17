class MenuModel {
  num? code;
  String? message;
  List<MenuItem>? menu;

  MenuModel({this.code, this.message, this.menu});

  MenuModel.fromJson(Map<String, dynamic> json) {
    code = json['SonucKod'];
    message = json['SonucMesaj'];
    if (json['Data'] != null) {
      menu = <MenuItem>[];
      json['Data'].forEach((v) {
        menu!.add(MenuItem.fromJson(v));
      });
    }
  }
}

/// Ansayfadaki menüler bu modele göre çiziliyor.
/// Eğer [type] 0 ise 'Kişisel Bilgiler', 1 ise
/// 'Kurumsal Bilgiler' adlı başlık altında gösteriliyor.
class MenuItem {
  num? id;
  num? menuDetailId;
  String? menuName;
  String? menuUrl;
  String? menuDynamicUrl;
  num? order;
  String? icon;
  bool? read;
  bool? add;
  bool? update;
  bool? delete;
  bool? report;
  num? type;

  MenuItem(
      {this.id,
      this.menuDetailId,
      this.menuName,
      this.menuUrl,
      this.menuDynamicUrl,
      this.order,
      this.icon,
      this.read,
      this.add,
      this.update,
      this.delete,
      this.report,
      this.type});

  MenuItem.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    menuDetailId = json['MENU_DETAY_ID'];
    menuName = json['MENU_ADI'];
    menuUrl = json['MENU_URL'];
    menuDynamicUrl = json['MENU_DINAMIK_URL'];
    order = json['SIRA'];
    icon = json['IKON'];
    read = json['OKUMA'];
    add = json['EKLEME'];
    update = json['GUNCELLEME'];
    delete = json['SILME'];
    report = json['RAPOR'];
    type = json['TIP'];
  }
}
