import 'package:dio/dio.dart';

/// Sunucudan dönen hata gövdesini kullanıcıya gösterilebilir metne çevirir.
String parseApiErrorMessage(DioException err, {String fallback = 'Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.'}) {
  if (err.type == DioExceptionType.connectionError ||
      err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.sendTimeout ||
      err.type == DioExceptionType.receiveTimeout) {
    final message = err.message?.toLowerCase() ?? '';
    if (message.contains('failed host lookup') || message.contains('no address associated')) {
      return 'Sunucuya bağlanılamadı. İnternet bağlantınızı veya kurum VPN erişiminizi kontrol edin.';
    }
    if (message.contains('connection refused')) {
      return 'Sunucu bağlantıyı reddetti. Lütfen daha sonra tekrar deneyiniz.';
    }
    if (message.contains('timed out')) {
      return 'Sunucu yanıt vermedi. Lütfen daha sonra tekrar deneyiniz.';
    }
    return 'Sunucuya bağlanılamadı. İnternet bağlantınızı kontrol edin.';
  }

  final data = err.response?.data;
  if (data == null) {
    return err.message ?? fallback;
  }
  if (data is Map) {
    if (data['error_description'] != null) {
      return data['error_description'].toString();
    }
    if (data['error'] != null) {
      return data['error'].toString();
    }
    if (data['Mesaj'] != null) {
      return data['Mesaj'].toString();
    }
    if (data['SonucMesaj'] != null) {
      return data['SonucMesaj'].toString();
    }
  }
  final text = data.toString();
  if (_looksLikeHtml(text)) {
    final code = err.response?.statusCode;
    if (code == 404) {
      return 'İstenen servis bulunamadı (404).';
    }
    if (code == 403) {
      return 'Bu işlem için yetkiniz bulunmuyor.';
    }
    return fallback;
  }
  return text.isNotEmpty ? text : fallback;
}

/// Sunucunun iç ağ (UBS) bağlantı hatalarını sadeleştirir.
String sanitizeServerMessage(
  String? message, {
  String fallback = 'Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.',
}) {
  if (message == null || message.trim().isEmpty) {
    return fallback;
  }
  final lower = message.toLowerCase();
  if (lower.contains('10.11.') ||
      lower.contains('10.10.') ||
      lower.contains('bağlantı kurulamadı') ||
      lower.contains('ana bilgisayar yanıt vermedi') ||
      lower.contains('connection refused') ||
      lower.contains('timed out')) {
    return 'Sefer bilgileri şu an alınamıyor. Ulaşım sunucusuna kurum tarafından erişilemiyor; lütfen daha sonra tekrar deneyin veya bilgi işlem birimine başvurun.';
  }
  return message;
}

bool _looksLikeHtml(String text) {
  final lower = text.toLowerCase();
  return lower.contains('<!doctype') ||
      lower.contains('<html') ||
      lower.contains('<head>') ||
      lower.contains('404 - file or directory not found');
}

/// Yanıt gövdesinin JSON nesnesi olup olmadığını kontrol eder.
bool isJsonMap(dynamic data) => data is Map<String, dynamic>;

Map<String, dynamic> requireJsonMap(dynamic data, {String fallbackMessage = 'Sunucudan geçersiz yanıt alındı.'}) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  if (data is String && _looksLikeHtml(data)) {
    throw DioException(
      requestOptions: RequestOptions(path: ''),
      message: fallbackMessage,
      type: DioExceptionType.badResponse,
    );
  }
  throw DioException(
    requestOptions: RequestOptions(path: ''),
    message: fallbackMessage,
    type: DioExceptionType.badResponse,
  );
}
