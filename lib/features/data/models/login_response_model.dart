class LoginResponseModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  String? issued;
  String? expires;

  LoginResponseModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.issued,
    this.expires,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    issued = json['.issued'];
    expires = json['.expires'];
  }
}
