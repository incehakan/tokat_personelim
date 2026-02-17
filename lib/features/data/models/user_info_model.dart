import 'package:hive_flutter/hive_flutter.dart';

part 'user_info_model.g.dart';

class UserInfoModel {
  num? sonucKod;
  String? sonucMesaj;
  UserInfo? userInfo;

  UserInfoModel({
    this.sonucKod,
    this.sonucMesaj,
    this.userInfo,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    sonucKod = json['SonucKod'];
    sonucMesaj = json['SonucMesaj'];
    userInfo = json['Data'] != null ? UserInfo.fromJson(json['Data']) : null;
  }
}

@HiveType(typeId: 0)
class UserInfo extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? surname;
  @HiveField(2)
  String? photo;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? birthdate;
  @HiveField(7)
  String? workplaceName;

  /// Sicil No
  @HiveField(8)
  num? registerNo;

  /// Tc Kimlik No
  @HiveField(9)
  num? registryNo;

  /// Ünvan
  @HiveField(10)
  String? title;

  /// Kadro Yeri Başkanlık
  @HiveField(11)
  String? staffPositionLocation;

  /// Kadro Yeri Adı
  @HiveField(12)
  String? staffPositionName;

  /// Fiili Yeri Başkanlık
  @HiveField(13)
  String? actualPlace;

  /// Personel Türü Adı
  @HiveField(14)
  String? personelTypeName;

  /// Sgk Meslek Kodu
  @HiveField(15)
  String? sgkProfessionCode;

  /// Sgk İşyeri
  @HiveField(16)
  String? sgkWorkPlace;

  /// Görev Yeri Adı
  @HiveField(17)
  String? dutyPlaceName;

  /// Fiili Görev
  @HiveField(18)
  String? actualTask;

  /// Kadro Görevi
  @HiveField(19)
  String? staffDuty;

  /// Dahili telefon numarası
  @HiveField(20)
  String? numercom;

  /// Kurum başlangıç Tarihi
  @HiveField(21)
  String? startingDate;

  bool get isBirthdayToday =>
      birthdate.toString().split(".")[0] == DateTime.now().day.toString().padLeft(2, "0") &&
      birthdate.toString().split(".")[0] == DateTime.now().month.toString().padLeft(2, "0");

  UserInfo({
    this.name,
    this.photo,
    this.registerNo,
    this.registryNo,
    this.phoneNumber,
    this.title,
    this.staffPositionLocation,
    this.staffPositionName,
    this.actualPlace,
    this.personelTypeName,
    this.sgkProfessionCode,
    this.sgkWorkPlace,
    this.email,
    this.address,
    this.dutyPlaceName,
    this.actualTask,
    this.staffDuty,
    this.surname,
    this.birthdate,
    this.workplaceName,
    this.numercom,
    this.startingDate,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['ADI'];
    photo = json['FOTOGRAF'];
    registerNo = json['SICIL_NO'];
    registryNo = json['TC_KIMLIK_NO'];
    phoneNumber = json['CEP_TELEFONU'];
    title = json['UNVAN'];
    staffPositionLocation = json['KADRO_YERI_BASKANLIK'];
    staffPositionName = json['KADRO_YERI_ADI'];
    actualPlace = json['FIILI_YERI_BASKANLIK'];
    personelTypeName = json['PERSONEL_TURU_ADI'];
    sgkProfessionCode = json['SGK_MESLEK_KODU'];
    sgkWorkPlace = json['SGK_ISYERI'];
    email = json['E_POSTA'];
    address = json['ADRES'];
    dutyPlaceName = json['GOREV_YERI_ADI'];
    actualTask = json['FIILI_GOREVI'];
    staffDuty = json['KADRO_GOREVI'];
    surname = json['SOYADI'];
    birthdate = json['DOGUM_TARIHI'];
    workplaceName = json['ISYERI_ADI'];
    numercom = json['DAHILI_NO'];
    startingDate = json['KURUM_BASLANGIC_TARIHI'];
  }
}
