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
    read = _parsePermissionFlag(json['OKUMA']);
    add = _parsePermissionFlag(json['EKLEME']);
    update = _parsePermissionFlag(json['GUNCELLEME']);
    delete = _parsePermissionFlag(json['SILME']);
    report = _parsePermissionFlag(json['RAPOR']);
    type = json['TIP'];
  }

  /// Sunucunun `OKUMA` alanı true değilse menü gösterilmez.
  bool get isVisible => read == true;
}

bool? _parsePermissionFlag(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
  }
  return null;
}
