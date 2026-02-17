class AppointmentModel {
  AppointmentModel({
    this.code,
    this.message,
    this.appointmentList,
  });

  String? code;
  String? message;
  List<AppointmentList>? appointmentList;

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    code = json["SONUC_KODU"];
    message = json["SONUC_MESAJI"];
    appointmentList = json["SONUC_LISTE"] == null
        ? null
        : List<AppointmentList>.from(
            json["SONUC_LISTE"].map((x) => AppointmentList.fromJson(x)),
          );
  }
}

class AppointmentList {
  AppointmentList({
    this.rowError,
    this.rowState,
    this.appointments,
    this.itemArray,
    this.hasErrors,
  });

  String? rowError;
  int? rowState;
  List<Appointment>? appointments;
  List<dynamic>? itemArray;
  bool? hasErrors;

  AppointmentList.fromJson(Map<String, dynamic> json) {
    rowError = json["RowError"];
    rowState = json["RowState"];
    appointments = json["Table"] == null ? null : List<Appointment>.from(json["Table"].map((x) => Appointment.fromJson(x)));
    itemArray = json["ItemArray"] == null ? null : List<dynamic>.from(json["ItemArray"].map((x) => x));
    hasErrors = json["HasErrors"];
  }
}

class Appointment {
  Appointment({
    this.protokolNo,
    this.protokolId,
    this.randevuTarihi,
    this.servisAdi,
  });

  double? protokolNo;
  double? protokolId;
  DateTime? randevuTarihi;
  String? servisAdi;

  Appointment.fromJson(Map<String, dynamic> json) {
    protokolNo = json["PROTOKOL_NO"];
    protokolId = json["PROTOKOL_ID"];
    randevuTarihi = json["RANDEVU_TARIHI"] == null ? null : DateTime.parse(json["RANDEVU_TARIHI"]);
    servisAdi = json["SERVIS_ADI"];
  }
}
