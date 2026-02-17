class ServiceErrorModel {
  String? error;
  String? errorDescription;

  ServiceErrorModel({this.error, this.errorDescription});

  ServiceErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorDescription = json['error_description'];
  }
}
