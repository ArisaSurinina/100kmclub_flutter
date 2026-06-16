import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool yearly = true;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
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
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 512),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 24),
                    _freeCard(),
                    const SizedBox(height: 32),
                    _trialCard(),
                    const SizedBox(height: 32),
                    _paidCard(),
                    const SizedBox(height: 24),
                    _bottomNote(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.06),
            ),
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 22,
              color: Color.fromRGBO(255, 255, 255, 0.6),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Plan',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                children: [
                  const Text(
                    'Unlock the full ',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                      fontSize: 18,
                    ),
                  ),
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Text(
                    ' experience',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _freeCard() {
    return _planCard(
      accent: const Color(0xFF2EE6A6),
      borderColor: const Color.fromRGBO(46, 230, 166, 0.25),
      backgroundStart: const Color.fromRGBO(46, 230, 166, 0.08),
      backgroundEnd: const Color.fromRGBO(46, 230, 166, 0.02),
      icon: Icons.bolt_outlined,
      pillText: 'Free plan · €0',
      title: 'Build the habit on your own.',
      features: const [
        'Walk on your own',
        'Build your personal monthly streak',
        'Your walking history stays with you',
      ],
      buttonText: 'Continue on your own',
    );
  }

  Widget _trialCard() {
    return _planCard(
      accent: const Color(0xFF2EE6A6),
      borderColor: const Color.fromRGBO(46, 230, 166, 0.25),
      backgroundStart: const Color.fromRGBO(46, 230, 166, 0.08),
      backgroundEnd: const Color.fromRGBO(46, 230, 166, 0.02),
      icon: Icons.auto_awesome,
      badgeText: 'Recommended',
      badgeColor1: const Color(0xFF2EE6A6),
      badgeColor2: const Color(0xFF1EC896),
      pillText: '3 months free trial · €0',
      title: "See what it's like to walk together.",
      features: const [
        'Create walking groups with friends',
        'Track your personal and group walk history',
        'Keep personal and group streaks',
        'Collect points and turn your walks into rewards',
      ],
      supportText:
          'Turn walking into a habit that actually sticks — shared streaks make skipping harder.',
      buttonText: 'Start free trial',
    );
  }

  Widget _paidCard() {
    return _planCard(
      accent: const Color(0xFFFFB832),
      borderColor: const Color.fromRGBO(255, 180, 50, 0.3),
      backgroundStart: const Color.fromRGBO(255, 180, 50, 0.12),
      backgroundEnd: const Color.fromRGBO(255, 150, 30, 0.05),
      icon: Icons.workspace_premium_outlined,
      badgeText: 'Best value',
      badgeColor1: const Color(0xFFFFB832),
      badgeColor2: const Color(0xFFFF9500),
      title: 'Keep walking together.',
      showBilling: true,
      features: const [
        'Create walking groups with friends',
        'Track your personal and group walk history',
        'Keep personal and group streaks',
        'Collect points and turn your walks into rewards',
      ],
      supportText:
          'Turn walking into a habit that actually sticks — shared streaks make skipping harder.',
      buttonText: 'Commit together',
    );
  }

  Widget _planCard({
    required Color accent,
    required Color borderColor,
    required Color backgroundStart,
    required Color backgroundEnd,
    required IconData icon,
    required String title,
    required List<String> features,
    required String buttonText,
    String? pillText,
    String? badgeText,
    Color? badgeColor1,
    Color? badgeColor2,
    String? supportText,
    bool showBilling = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [backgroundStart, backgroundEnd],
            ),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.35),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (pillText != null) ...[
                _pricePill(pillText),
                const SizedBox(height: 20),
                _divider(),
                const SizedBox(height: 20),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _iconBox(icon, accent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                      ),
                    ),
                  ),
                ],
              ),
              if (showBilling) ...[
                const SizedBox(height: 28),
                _billingToggle(),
                const SizedBox(height: 26),
                _priceBlock(),
              ],
              const SizedBox(height: 26),
              ...features.map((text) => _featureRow(text, accent)),
              if (supportText != null) ...[
                const SizedBox(height: 20),
                _divider(),
                const SizedBox(height: 16),
                Text(
                  supportText,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.55),
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 28),
              _primaryButton(buttonText),
            ],
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: -14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  colors: [
                    badgeColor1 ?? const Color(0xFF2EE6A6),
                    badgeColor2 ?? const Color(0xFF1EC896),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (badgeColor1 ?? const Color(0xFF2EE6A6))
                        .withOpacity(0.45),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Text(
                badgeText,
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.85),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _pricePill(String text) {
  return Container(
    width: double.infinity,
    constraints: const BoxConstraints(
      minHeight: 44,
    ),
    alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 180, 50, 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 180, 50, 0.25),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.6),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon, Color accent) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withOpacity(0.25)),
      ),
      child: Icon(
        icon,
        color: accent,
        size: 28,
      ),
    );
  }

  Widget _featureRow(String text, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: accent.withOpacity(0.25)),
            ),
            child: Icon(
              Icons.check,
              color: accent,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.75),
                fontSize: 18,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _billingToggle() {
    return Container(
      height: 66,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.08),
        ),
      ),
      child: Row(
        children: [
          _billingTab('Monthly', !yearly),
          _billingTab('Yearly', yearly, showSave: true),
        ],
      ),
    );
  }

  Widget _billingTab(String text, bool active, {bool showSave = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            yearly = text == 'Yearly';
          });
        },
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: active
                ? const Color.fromRGBO(255, 255, 255, 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: showSave
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: active
                              ? const Color.fromRGBO(255, 255, 255, 0.95)
                              : const Color.fromRGBO(255, 255, 255, 0.5),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(46, 230, 166, 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '★ Save 33%',
                          style: TextStyle(
                            color: Color(0xFF2EE6A6),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: active
                          ? const Color.fromRGBO(255, 255, 255, 0.95)
                          : const Color.fromRGBO(255, 255, 255, 0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _priceBlock() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: yearly ? '€12' : '€1.50',
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.95),
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: yearly ? ' / year' : ' / month',
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (yearly) ...[
            const SizedBox(height: 8),
            const Text(
              "That’s just €1 per month",
              style: TextStyle(
                color: Color(0xFF2EE6A6),
                fontSize: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _primaryButton(String text) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    },
    child: Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2EE6A6),
            Color(0xFF1EC896),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(46, 230, 166, 0.3),
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
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

  Widget _divider() {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color.fromRGBO(255, 255, 255, 0.06),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _bottomNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.05),
        ),
      ),
      child: const Center(
        child: Text(
          'Cancel anytime. No questions asked.',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.5),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}