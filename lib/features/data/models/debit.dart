class DebitModel {
  int? code;
  String? message;
  DebitInfo? debitInfo;

  DebitModel({
    this.code,
    this.message,
    this.debitInfo,
  });

  DebitModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    debitInfo = json["Data"] == null ? null : DebitInfo.fromJson(json["Data"]);
  }
}

class DebitInfo {
  /// Taşınır Kayıt Yetkilisi
  String? registrationAuthority;
  List<Debit>? debits;

  DebitInfo({
    this.registrationAuthority,
    this.debits,
  });

  DebitInfo.fromJson(Map<String, dynamic> json) {
    registrationAuthority = json["TasinirKayitYetkilisi"];
    debits = json["Zimmetler"] == null ? null : List<Debit>.from(json["Zimmetler"].map((x) => Debit.fromJson(x)));
  }
}

class Debit {
  /// Demirbaş No
  double? fixtureNo;

  /// Name
  String? name;

  /// Birim
  String? unit;

  /// Birim Id
  double? unitId;

  Debit({
    this.fixtureNo,
    this.name,
    this.unit,
    this.unitId,
  });

  Debit.fromJson(Map<String, dynamic> json) {
    fixtureNo = json["DemirbasNo"];
    name = json["Adı"];
    unit = json["Birim"];
    unitId = json["BirimId"];
  }
}
