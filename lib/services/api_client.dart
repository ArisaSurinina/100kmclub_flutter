class ApiClient {
  static const String backendBaseUrl =
      'https://100kmclubemergent-production.up.railway.app';

  static const String apiRoot = '$backendBaseUrl/api';

  static Uri uri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$apiRoot$normalizedPath');
  }
}