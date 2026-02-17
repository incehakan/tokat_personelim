class FeedModel {
  FeedModel({
    this.code,
    this.message,
    this.feeds,
  });

  int? code;
  String? message;
  List<Feed>? feeds;

  FeedModel.fromJson(Map<String, dynamic> json) {
    code = json["SonucKod"];
    message = json["SonucMesaj"];
    feeds = json["Data"] == null ? null : List<Feed>.from(json["Data"].map((x) => Feed.fromJson(x)));
  }
}

class Feed {
  Feed({
    this.baskanlikAdi,
    this.gonderiSayisi,
    this.id,
    this.sonGonderiTarihi,
  });

  String? baskanlikAdi;
  double? gonderiSayisi;
  double? id;
  DateTime? sonGonderiTarihi;

  Feed.fromJson(Map<String, dynamic> json) {
    baskanlikAdi = json["BASKANLIK_ADI"];
    gonderiSayisi = json["GONDERI_SAYISI"];
    id = json["ID"];
    sonGonderiTarihi = json["SON_GONDERI_TARIHI"] == null ? null : DateTime.parse(json["SON_GONDERI_TARIHI"]);
  }
}
