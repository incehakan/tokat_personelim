class LeaveModel {
  num? code;
  String? message;
  LeaveInfo? leaveInfo;

  LeaveModel({this.code, this.message, this.leaveInfo});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    code = json['SonucKod'];
    message = json['SonucMesaj'];
    leaveInfo = json['Data'] != null ? LeaveInfo.fromJson(json['Data']) : null;
  }
}

class LeaveInfo {
  /// Kalan Yıllık İzin
  num? remainAnnualLeave;

  /// Kullanılan Yıllık İzin
  num? usedAnnualLeave;
  List<Leave>? leaves;

  LeaveInfo({this.remainAnnualLeave, this.usedAnnualLeave, this.leaves});

  LeaveInfo.fromJson(Map<String, dynamic> json) {
    remainAnnualLeave = json['KalanGunSayisi'];
    usedAnnualLeave = json['KullanilanGunSayisi'];
    if (json['Izinler'] != null) {
      leaves = <Leave>[];
      json['Izinler'].forEach((v) {
        leaves!.add(Leave.fromJson(v));
      });
    }
  }

  num get percentage => remainAnnualLeave! / (remainAnnualLeave! + usedAnnualLeave!);
}

class Leave {
  num? employeeId;
  String? type;
  String? startingDate;
  String? endDate;
  num? dayOffCount;
  String? description;

  Leave({
    this.employeeId,
    this.type,
    this.startingDate,
    this.endDate,
    this.dayOffCount,
    this.description,
  });

  Leave.fromJson(Map<String, dynamic> json) {
    employeeId = json['PERSONEL_ID'];
    type = json['TUR'];
    startingDate = json['BASLANGIC_TARIHI'];
    endDate = json['BITIS_TARIHI'];
    dayOffCount = json['KULLANILAN_GUN'];
    description = json['ACIKLAMA'];
  }
}
