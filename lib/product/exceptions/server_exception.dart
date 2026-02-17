class ServerException {
  final String message;
  final String? statusCode;

  ServerException(
    this.message, {
    this.statusCode,
  });
}
