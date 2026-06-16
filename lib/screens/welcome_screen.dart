import 'package:flutter/material.dart';
import 'onboarding_challenge_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              const Spacer(flex: 9),
              Column(
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
                        backgroundColor: Color.fromRGBO(46, 230, 166, 0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    '100KM club',
                    style: TextStyle(
                      color: Color(0xFF2EE6A6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.92,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 32,
                    height: 1,
                    color: const Color.fromRGBO(46, 230, 166, 0.12),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Build a walking habit',
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
                    'One simple monthly goal.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.55),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.34,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    const Text(
                      'Your first month begins here',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.45),
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
                            builder: (_) =>
                                const OnboardingChallengeScreen(),
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
                                'Begin',
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