class ApiClient {
  static const String backendBaseUrl =
      'https://source-of-truth-15.preview.emergentagent.com';

  static const String apiRoot = '$backendBaseUrl/api';

  static Uri uri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$apiRoot$normalizedPath');
  }
}