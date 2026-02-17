class AvailableDeviceLocationResponse {
  AvailableDeviceLocationResponse({
    this.code,
    this.message,
    this.locations,
  });

  int? code;
  String? message;
  List<DeviceLocation>? locations;

  AvailableDeviceLocationResponse.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    locations = json["Data"] == null ? null : List<DeviceLocation>.from(json["Data"].map((x) => DeviceLocation.fromJson(x)));
  }
}

class DeviceLocation {
  DeviceLocation({
    this.id,
    this.adi,
    this.koordinatX,
    this.koordinatY,
  });

  double? id;
  String? adi;
  dynamic koordinatX;
  dynamic koordinatY;

  DeviceLocation.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    adi = json["ADI"];
    koordinatX = json["KOORDINAT_X"];
    koordinatY = json["KOORDINAT_Y"];
  }
}
