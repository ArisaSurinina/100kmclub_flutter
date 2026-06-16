import 'package:flutter/material.dart';
import 'auth_screen.dart';

class OnboardingChallengeScreen extends StatelessWidget {
  const OnboardingChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1F),
              Color(0xFF0F0F12),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromRGBO(46, 230, 166, 0.18),
                            width: 1.5,
                          ),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor:
                                Color.fromRGBO(46, 230, 166, 0.6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        '100 km every month',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.75),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.3,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'alone or with a team',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.55),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.34,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: 32,
                        height: 1,
                        color: const Color.fromRGBO(255, 255, 255, 0.14),
                      ),
                      const SizedBox(height: 32),
                      const SizedBox(
                        width: 260,
                        child: Text(
                          'A simple monthly goal to help you walk more.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.55),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.16,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    const Text(
                      'Start your first month',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.38),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AuthScreen(),
                          ),
                        );
                      },
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 320),
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(46, 230, 166, 0.88),
                                  Color.fromRGBO(30, 200, 140, 0.88),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Continue →',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.85),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}