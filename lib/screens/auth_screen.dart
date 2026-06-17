import 'package:flutter/material.dart';
import 'subscription_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool staySignedIn = true;
  bool loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _continueToSubscription() {
    setState(() {
      loading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SubscriptionScreen(),
        ),
      );
    });
  }

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
              top: 0,
              left: -8,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.chevron_left,
                    color: Color.fromRGBO(255, 255, 255, 0.45),
                    size: 30,
                  ),
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
                      _brand(),
                      const SizedBox(height: 40),
                      _tabs(),
                      const SizedBox(height: 32),
                      isLogin ? _loginForm() : _registerForm(),
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

  Widget _brand() {
    return Column(
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
            textAlign: TextAlign.center,
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
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.35),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _tabs() {
    return Container(
      width: double.infinity,
      height: 36,
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
            boxShadow: active
                ? const [
                    BoxShadow(
                      color: Color.fromRGBO(46, 180, 130, 0.15),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ]
                : [],
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

  Widget _loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Email'),
        const SizedBox(height: 8),
        _textField(
          controller: emailController,
          hint: 'you@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _label('Password'),
        const SizedBox(height: 8),
        _passwordField(
          controller: passwordController,
          hint: '••••••••',
          visible: showPassword,
          onToggle: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        const SizedBox(height: 20),
        _staySignedIn(),
        const SizedBox(height: 20),
        _primaryButton(loading ? 'Signing in…' : 'Log In'),
      ],
    );
  }

  Widget _registerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Name'),
        const SizedBox(height: 8),
        _textField(
          controller: nameController,
          hint: 'Your name',
        ),
        const SizedBox(height: 20),
        _label('Email'),
        const SizedBox(height: 8),
        _textField(
          controller: emailController,
          hint: 'you@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _label('Password'),
        const SizedBox(height: 8),
        _passwordField(
          controller: passwordController,
          hint: '••••••••',
          visible: showPassword,
          onToggle: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        const SizedBox(height: 20),
        _label('Confirm password'),
        const SizedBox(height: 8),
        _passwordField(
          controller: confirmPasswordController,
          hint: '••••••••',
          visible: showConfirmPassword,
          onToggle: () {
            setState(() {
              showConfirmPassword = !showConfirmPassword;
            });
          },
        ),
        const SizedBox(height: 20),
        _staySignedIn(),
        const SizedBox(height: 20),
        _primaryButton(loading ? 'Creating account…' : 'Sign Up'),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: !loading,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: _inputDecoration(hint),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      enabled: !loading,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: _inputDecoration(hint).copyWith(
        suffixIcon: GestureDetector(
          onTap: onToggle,
          child: Icon(
            visible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color.fromRGBO(255, 255, 255, 0.4),
            size: 18,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
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
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromRGBO(255, 255, 255, 0.06),
        ),
      ),
    );
  }

  Widget _staySignedIn() {
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: Checkbox(
            value: staySignedIn,
            onChanged: loading
                ? null
                : (value) {
                    setState(() {
                      staySignedIn = value ?? true;
                    });
                  },
            activeColor: const Color(0xFF10B981),
            checkColor: Colors.white,
            side: const BorderSide(
              color: Color.fromRGBO(255, 255, 255, 0.2),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: loading
              ? null
              : () {
                  setState(() {
                    staySignedIn = !staySignedIn;
                  });
                },
          child: const Text(
            'Stay signed in',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.4),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _primaryButton(String text) {
    return GestureDetector(
      onTap: loading ? null : _continueToSubscription,
      child: Opacity(
        opacity: loading ? 0.5 : 1,
        child: Container(
          width: double.infinity,
          height: 48,
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
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 8,
                offset: Offset(0, 2),
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
      ),
    );
  }
}