import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_client.dart';

class AuthService {
  static Future<String> login({
    required String email,
    required String password,
    String? timezone,
  }) async {
    debugPrint('AUTH SERVICE LOGIN METHOD STARTED');

    final loginUrl = ApiClient.uri('/auth/login');
    debugPrint('LOGIN URL: $loginUrl');

    final response = await http.post(
      loginUrl,
      headers: const {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email.trim(),
        'password': password,
        if (timezone != null) 'timezone': timezone,
      }),
    );

    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (_) {
      throw AuthException(
        'Server returned ${response.statusCode}: ${response.body}',
      );
    }

    if (response.statusCode == 200) {
      final token = body['access_token'];

      if (token is String && token.isNotEmpty) {
        return token;
      }

      throw AuthException('Login succeeded but token was missing.');
    }

    if (body is Map && body['detail'] is String) {
      throw AuthException(body['detail'] as String);
    }

    throw AuthException('Login failed. Please try again.');
  }

  static Future<Map<String, dynamic>> getCurrentUser({
    required String token,
    String? timezone,
  }) async {
    final uri = timezone == null
        ? ApiClient.uri('/auth/me')
        : ApiClient.uri('/auth/me').replace(
            queryParameters: {
              'timezone': timezone,
            },
          );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (_) {
      throw AuthException(
        'Server returned ${response.statusCode}: ${response.body}',
      );
    }

    if (response.statusCode == 200 && body is Map<String, dynamic>) {
      return body;
    }

    if (body is Map && body['detail'] is String) {
      throw AuthException(body['detail'] as String);
    }

    throw AuthException('Failed to load current user.');
  }
}

class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}