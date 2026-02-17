class PdksDeviceModel {
  PdksDeviceModel({
    this.code,
    this.message,
    this.devices,
  });

  int? code;
  String? message;
  List<PdksDevice>? devices;

  PdksDeviceModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    devices = List<PdksDevice>.from(json["Data"].map((x) => PdksDevice.fromJson(x)));
  }
}

class PdksDevice {
  PdksDevice({
    this.id,
    this.adi,
    this.koordinatX,
    this.koordinatY,
  });

  double? id;
  String? adi;
  String? koordinatX;
  String? koordinatY;

  PdksDevice.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    adi = json["ADI"];
    koordinatX = json["KOORDINAT_X"];
    koordinatY = json["KOORDINAT_Y"];
  }
}
