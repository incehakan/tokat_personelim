/// İş takip API yanıtından ve AutoLogin URL'sinden link üretir.
String? extractJobTrackingBaseUrl(dynamic data) {
  if (data == null) return null;

  if (data is String) {
    return _normalizeBaseUrl(data);
  }

  if (data is Map) {
    final code = data['SonucKod'];
    if (code != null && code != 0) return null;

    for (final key in ['Data', 'data', 'LINK', 'Link', 'URL', 'Url']) {
      final value = data[key];
      if (value != null) {
        final link = extractJobTrackingBaseUrl(value);
        if (link != null) return link;
      }
    }
  }

  return _normalizeBaseUrl(data.toString());
}

String? _normalizeBaseUrl(String raw) {
  final link = raw.trim().replaceAll('"', '');
  if (link.isEmpty || link.toLowerCase() == 'null') return null;

  final uri = Uri.tryParse(link);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) return null;

  return link.endsWith('/') ? link.substring(0, link.length - 1) : link;
}

Uri? buildJobTrackingAutoLoginUri({
  required String baseUrl,
  required String? username,
  required String? password,
}) {
  if (username == null ||
      password == null ||
      username.isEmpty ||
      password.isEmpty) {
    return null;
  }

  final base = extractJobTrackingBaseUrl(baseUrl);
  if (base == null) return null;

  return Uri.parse('$base/AutoLogin').replace(
    queryParameters: {
      'username': username,
      'password': password,
    },
  );
}
