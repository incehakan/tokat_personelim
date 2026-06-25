import 'package:intl/intl.dart';

class SalaryModel {
  num? sonucKod;
  String? sonucMesaj;
  List<Salary>? salaries;

  SalaryModel({this.sonucKod, this.sonucMesaj, this.salaries});

  SalaryModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json['SonucKod'];
    sonucMesaj = json['SonucMesaj'];
    if (json['Data'] != null) {
      salaries = <Salary>[];
      json['Data'].forEach((v) {
        salaries!.add(Salary.fromJson(v));
      });
    }
  }
}

class Salary {
  num? registerNo;

  /// Bordro Türü
  String? payrollType;

  /// Bordro Ay
  num? payrollMonth;

  /// Bordro Yıl
  num? payrollYear;

  /// Net Maaş
  num? netSalary;

  /// Kesintiler
  num? salaryCuts;

  /// Brüt Maaş
  num? grossSalary;

  /// Ay
  String? month;

  /// Bordro Kodu
  String? payrollCode;

  Salary({
    this.registerNo,
    this.payrollType,
    this.payrollMonth,
    this.payrollYear,
    this.netSalary,
    this.salaryCuts,
    this.grossSalary,
    this.month,
    this.payrollCode,
  });

  Salary.fromJson(Map<String, dynamic> json) {
    registerNo = json['SICIL_NO'];
    payrollType = json['BORDRO_TURU'];
    payrollMonth = json['BORDRO_AY'];
    payrollYear = json['BORDRO_YIL'];
    netSalary = json['NET_MAAS'];
    salaryCuts = json['KESINTILER'];
    grossSalary = json['BRUT_MAAS'];
    month = json['AY'];
    payrollCode = json['BORDRO_KODU'];
  }

  final _format = NumberFormat("#,##0.00", "en_US");

  String? get formattedNetSalary =>
      netSalary != null ? _format.format(netSalary!.toDouble()) : null;

  String? get formattedGrossSalary =>
      grossSalary != null ? _format.format(grossSalary!.toDouble()) : null;

  String? get formattedSalaryCuts =>
      salaryCuts != null ? _format.format(salaryCuts!.toDouble()) : null;
}
