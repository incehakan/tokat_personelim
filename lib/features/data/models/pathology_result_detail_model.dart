class PatResultDetailModel {
  PatResultDetailModel({
    this.code,
    this.message,
    this.results,
  });

  String? code;
  String? message;
  List<PatResultDetail>? results;

  factory PatResultDetailModel.fromJson(Map<String, dynamic> json) => PatResultDetailModel(
        code: json["SonucKod"],
        message: json["SonucMsg"],
        results: json["SonucListe"] == null
            ? null
            : List<PatResultDetail>.from(
                json["SonucListe"].map((x) => PatResultDetail.fromJson(x)),
              ),
      );
}

class PatResultDetail {
  PatResultDetail({
    this.result,
  });

  String? result;

  PatResultDetail.fromJson(Map<String, dynamic> json) {
    result = json["PAT_SONUC"];
  }
}
