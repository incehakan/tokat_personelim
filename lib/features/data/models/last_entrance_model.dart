class LastEntranceModel {
  int? code;
  String? message;
  List<LastEntrance>? lastEntrance;

  LastEntranceModel({this.code, this.message, this.lastEntrance});

  LastEntranceModel.fromJson(Map<String, dynamic> json) {
    code = json['SonucKod'];
    message = json['SonucMesaj'];
    if (json['Data'] != null) {
      lastEntrance = <LastEntrance>[];
      json['Data'].forEach((v) {
        lastEntrance!.add(LastEntrance.fromJson(v));
      });
    }
  }
}

class LastEntrance {
  num? id;
  num? entranceType;
  DateTime? date;

  LastEntrance({this.id, this.entranceType, this.date});

  LastEntrance.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    entranceType = json['GECIS_TURU'];
    date = json['TARIH'] == null ? null : DateTime.parse(json["TARIH"]);
  }

  // DateTime get _parsedDate => DateTime.parse(date!);

  // String get entranceDate => DateFormat.yMd('tr').format(_parsedDate);

  // String get entranceTime => '${_parsedDate.hour}:${_parsedDate.minute}';
}
