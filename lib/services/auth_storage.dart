import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();

  static const String tokenKey = '100kmclub_token';
  static const String userKey = '100kmclub_user';

  static Future<void> saveAuth({
    required String token,
    required Map<String, dynamic> user,
  }) async {
    await _storage.write(key: tokenKey, value: token);
    await _storage.write(key: userKey, value: jsonEncode(user));
  }

  static Future<String?> readToken() {
    return _storage.read(key: tokenKey);
  }

  static Future<Map<String, dynamic>?> readUser() async {
    final value = await _storage.read(key: userKey);

    if (value == null) {
      return null;
    }

    final decoded = jsonDecode(value);

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return null;
  }

  static Future<void> clearAuth() async {
    await _storage.delete(key: tokenKey);
    await _storage.delete(key: userKey);
  }
}