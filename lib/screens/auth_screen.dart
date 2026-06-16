import 'package:flutter/material.dart';
import 'subscription_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool staySignedIn = true;
  bool showLoginPassword = false;
  bool showRegisterPassword = false;
  bool showConfirmPassword = false;
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1F),
              Color(0xFF16161A),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: -8,
              child: IconButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                icon: const Icon(
                  Icons.chevron_left,
                  size: 32,
                  color: Color.fromRGBO(255, 255, 255, 0.45),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              Color(0xFF2EE6A6),
                              Color(0xFFFF8A50),
                            ],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          '100KM club',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Walk 100km every month',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.35),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),

                      Container(
                        height: 56,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.03),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: const Color.fromRGBO(255, 255, 255, 0.05),
                          ),
                        ),
                        child: Row(
                          children: [
                            _tabButton('Log In', true),
                            _tabButton('Sign Up', false),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      if (isLogin) _loginForm() else _signupForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      children: [
        _label('Email'),
        const SizedBox(height: 8),
        _input('you@example.com'),

        const SizedBox(height: 20),

        _label('Password'),
        const SizedBox(height: 8),
        _passwordInput(
          showPassword: showLoginPassword,
          onToggle: () {
            setState(() {
              showLoginPassword = !showLoginPassword;
            });
          },
        ),

        const SizedBox(height: 20),

        _staySignedInRow(),

        const SizedBox(height: 16),

        _primaryButton('Log In'),
      ],
    );
  }

  Widget _signupForm() {
    return Column(
      children: [
        _label('Name'),
        const SizedBox(height: 8),
        _input('John Doe'),

        const SizedBox(height: 20),

        _label('Email'),
        const SizedBox(height: 8),
        _input('you@example.com'),

        const SizedBox(height: 20),

        _label('Password'),
        const SizedBox(height: 8),
        _passwordInput(
          showPassword: showRegisterPassword,
          onToggle: () {
            setState(() {
              showRegisterPassword = !showRegisterPassword;
            });
          },
        ),

        const SizedBox(height: 4),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'At least 8 characters',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.25),
              fontSize: 12,
            ),
          ),
        ),

        const SizedBox(height: 20),

        _label('Confirm Password'),
        const SizedBox(height: 8),
        _passwordInput(
          showPassword: showConfirmPassword,
          onToggle: () {
            setState(() {
              showConfirmPassword = !showConfirmPassword;
            });
          },
        ),

        const SizedBox(height: 20),

        _staySignedInRow(),

        const SizedBox(height: 16),

        _primaryButton('Create Account'),
      ],
    );
  }

  Widget _tabButton(String text, bool loginTab) {
    final active = isLogin == loginTab;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = loginTab;
          });
        },
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: active
                ? const Color.fromRGBO(46, 180, 130, 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: active
                  ? const Color.fromRGBO(46, 180, 130, 0.2)
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active
                    ? const Color.fromRGBO(180, 230, 200, 0.95)
                    : const Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.4),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _input(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: _inputDecoration(hint),
    );
  }

  Widget _passwordInput({
    required bool showPassword,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: !showPassword,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: _inputDecoration(
        '••••••••',
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            showPassword ? Icons.visibility_off : Icons.visibility,
            color: const Color.fromRGBO(255, 255, 255, 0.4),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.25),
      ),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.03),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.06),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromRGBO(46, 230, 166, 0.3),
        ),
      ),
    );
  }

  Widget _staySignedInRow() {
    return Row(
      children: [
        Checkbox(
          value: staySignedIn,
          activeColor: const Color(0xFF10B981),
          onChanged: (value) {
            setState(() {
              staySignedIn = value ?? true;
            });
          },
        ),
        const Text(
          'Stay signed in',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

Widget _primaryButton(String text) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SubscriptionScreen(),
        ),
      );
    },
    child: Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(46, 230, 166, 0.9),
            Color.fromRGBO(30, 200, 140, 0.9),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(46, 230, 166, 0.25),
            blurRadius: 25,
          ),
          BoxShadow(
            color: Color.fromRGBO(46, 230, 166, 0.15),
            blurRadius: 50,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.85),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.14,
          ),
        ),
      ),
    ),
  );
}
}