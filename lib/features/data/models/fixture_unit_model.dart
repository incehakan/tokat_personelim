class FixtureUnitModel {
  FixtureUnitModel({
    this.code,
    this.message,
    this.units,
  });

  int? code;
  String? message;
  List<FixtureUnit>? units;

  FixtureUnitModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    units = List<FixtureUnit>.from(json["Data"].map((x) => FixtureUnit.fromJson(x)));
  }
}

class FixtureUnit {
  FixtureUnit({
    this.id,
    this.adi,
  });

  double? id;
  String? adi;

  FixtureUnit.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    adi = json["ADI"];
  }
}
