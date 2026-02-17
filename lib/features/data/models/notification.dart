class NotificationResponse {
  NotificationResponse({
    this.sonucKod,
    this.sonucMesaj,
    this.notifications,
  });

  int? sonucKod;
  String? sonucMesaj;
  List<PrsNotification>? notifications;

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    sonucKod = json["SonucKod"];
    sonucMesaj = json["SonucMesaj"];
    notifications = json["Data"] == null
        ? null
        : List<PrsNotification>.from(
            json["Data"].map((x) => PrsNotification.fromJson(x)),
          );
  }
}

class PrsNotification {
  PrsNotification({
    this.baslik,
    this.bildirimId,
    this.gonderimTarihi,
    this.icerik,
    this.id,
    this.kullaniciId,
  });

  String? baslik;
  double? bildirimId;
  DateTime? gonderimTarihi;
  String? icerik;
  double? id;
  double? kullaniciId;

  PrsNotification.fromJson(Map<String, dynamic> json) {
    baslik = json["BASLIK"];
    bildirimId = json["BILDIRIM_ID"];
    gonderimTarihi = json["GONDERIM_TARIHI"] == null ? null : DateTime.parse(json["GONDERIM_TARIHI"]);
    icerik = json["ICERIK"];
    id = json["ID"];
    kullaniciId = json["KULLANICI_ID"];
  }
}
