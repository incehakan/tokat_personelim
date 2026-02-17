class HospitalTokenModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  HospitalTokenModel({this.accessToken, this.tokenType, this.expiresIn});

  HospitalTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }
}
