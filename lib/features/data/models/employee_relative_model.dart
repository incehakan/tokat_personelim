class EmployeeRelativeModel {
  int? code;
  String? message;
  List<Relative>? relatives;

  EmployeeRelativeModel({this.code, this.message, this.relatives});

  EmployeeRelativeModel.fromJson(Map<String, dynamic> json) {
    code = json['SonucKod'];
    message = json['SonucMesaj'];
    if (json['Data'] != null) {
      relatives = <Relative>[];
      json['Data'].forEach((v) {
        relatives!.add(Relative.fromJson(v));
      });
    }
  }
}

class Relative {
  num? registerId;
  String? relativeDegree;
  num? registryNo;
  String? fullName;

  Relative(Relative relativ, {this.registerId, this.relativeDegree, this.registryNo, this.fullName});

  Relative.fromJson(Map<String, dynamic> json) {
    registerId = json['SICIL_ID'];
    relativeDegree = json['YAKINLIK_DERECESI'];
    registryNo = json['TC_KIMLIK_NO'];
    fullName = json['ADI_SOYADI'];
  }
}
