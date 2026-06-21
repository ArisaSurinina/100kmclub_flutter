import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/auth_storage.dart';
import 'subscription_screen.dart';
import 'auth_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {

  debugPrint('AUTH GATE STARTED');

  final token = await AuthStorage.readToken();

debugPrint('AUTH GATE TOKEN EXISTS: ${token != null}');

if (!mounted) return;

if (token == null) {
  debugPrint('AUTH GATE: NO TOKEN, GOING TO WELCOME');
  _goToAuth();
  return;
}

    try {
      final user = await AuthService.getCurrentUser(
        token: token,
        timezone: DateTime.now().timeZoneName,
      );

      await AuthStorage.saveAuth(
        token: token,
        user: user,
      );

      debugPrint('SESSION RESTORED: ${user['email']}');

      _goToSubscription();
    } on AuthException catch (error) {
      debugPrint('SESSION RESTORE FAILED: ${error.message}');
      await AuthStorage.clearAuth();
      _goToAuth();
    } catch (error) {
      debugPrint('SESSION RESTORE ERROR: $error');
      _goToAuth();
    }
  }

  void _goToAuth() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const AuthScreen(),
    ),
  );
}

  void _goToSubscription() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SubscriptionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF16161A),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}