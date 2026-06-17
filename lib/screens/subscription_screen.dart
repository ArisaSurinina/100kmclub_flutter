import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedBilling = 'yearly';
  bool loading = false;

  void _goToDashboard() {
    setState(() {
      loading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
            child: Column(
              children: [
                _header(),
                const SizedBox(height: 32),
                _freeCard(),
                const SizedBox(height: 32),
                _trialCard(),
                const SizedBox(height: 32),
                _paidCard(),
                const SizedBox(height: 24),
                _reassuranceCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
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
            'Welcome to 100KM club!',
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
          'Choose how you want to build your walking habit.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.5),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _freeCard() {
    return _planCard(
      isGold: false,
      child: Column(
        children: [
          _labelBox('Free plan · €0'),
          _divider(),
          _headline(
            icon: Icons.bolt,
            title: 'Build the habit on your own.',
            isGold: false,
          ),
          const SizedBox(height: 20),
          _features(
            [
              'Walk on your own',
              'Build your personal monthly streak',
              'Your walking history stays with you',
            ],
            isGold: false,
          ),
          const SizedBox(height: 20),
          _ctaButton('Continue on your own'),
        ],
      ),
    );
  }

  Widget _trialCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _planCard(
          isGold: false,
          child: Column(
            children: [
              _labelBox('3 months free trial · €0'),
              _divider(),
              _headline(
                icon: Icons.auto_awesome,
                title: "See what it's like to walk together.",
                isGold: false,
              ),
              const SizedBox(height: 20),
              _features(
                [
                  'Create walking groups with friends',
                  'Track your personal and group walk history',
                  'Keep personal and group streaks',
                  'Collect points and turn your walks into rewards',
                ],
                isGold: false,
              ),
              _supportingLine(),
              const SizedBox(height: 20),
              _ctaButton('Start free trial'),
            ],
          ),
        ),
        _topBadge('Recommended', isGold: false),
      ],
    );
  }

  Widget _paidCard() {
    final isYearly = selectedBilling == 'yearly';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        _planCard(
          isGold: true,
          child: Column(
            children: [
              _headline(
                icon: Icons.workspace_premium,
                title: 'Keep walking together.',
                isGold: true,
              ),
              const SizedBox(height: 16),
              _billingToggle(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    isYearly ? '€12' : '€1.50',
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.95),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isYearly ? '/ year' : '/ month',
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (isYearly) ...[
                const SizedBox(height: 4),
                const Text(
                  "That's just €1 per month",
                  style: TextStyle(
                    color: Color(0xFF2EE6A6),
                    fontSize: 13,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              _features(
                [
                  'Create walking groups with friends',
                  'Track your personal and group walk history',
                  'Keep personal and group streaks',
                  'Collect points and turn your walks into rewards',
                ],
                isGold: true,
              ),
              _supportingLine(),
              const SizedBox(height: 20),
              _ctaButton('Commit together'),
            ],
          ),
        ),
        _topBadge('Best value', isGold: true),
      ],
    );
  }

  Widget _planCard({
    required bool isGold,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isGold
              ? const [
                  Color.fromRGBO(255, 180, 50, 0.12),
                  Color.fromRGBO(255, 150, 30, 0.05),
                ]
              : const [
                  Color.fromRGBO(46, 230, 166, 0.08),
                  Color.fromRGBO(46, 230, 166, 0.02),
                ],
        ),
        border: Border.all(
          color: isGold
              ? const Color.fromRGBO(255, 180, 50, 0.3)
              : const Color.fromRGBO(46, 230, 166, 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: isGold
                ? const Color.fromRGBO(255, 180, 50, 0.15)
                : const Color.fromRGBO(46, 230, 166, 0.1),
            blurRadius: 30,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _labelBox(String text) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 36),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 180, 50, 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 180, 50, 0.25),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 180, 50, 0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.6),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 20),
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

  Widget _headline({
    required IconData icon,
    required String title,
    required bool isGold,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isGold
                ? const Color.fromRGBO(255, 180, 50, 0.15)
                : const Color.fromRGBO(46, 230, 166, 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isGold
                  ? const Color.fromRGBO(255, 180, 50, 0.25)
                  : const Color.fromRGBO(46, 230, 166, 0.2),
            ),
          ),
          child: Icon(
            icon,
            color: isGold ? const Color(0xFFFFB832) : const Color(0xFF2EE6A6),
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _features(List<String> features, {required bool isGold}) {
    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isGold
                      ? const Color.fromRGBO(255, 180, 50, 0.15)
                      : const Color.fromRGBO(46, 230, 166, 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isGold
                        ? const Color.fromRGBO(255, 180, 50, 0.25)
                        : const Color.fromRGBO(46, 230, 166, 0.2),
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: isGold ? const Color(0xFFFFB832) : const Color(0xFF2EE6A6),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  feature,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.75),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _supportingLine() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(255, 255, 255, 0.06),
          ),
        ),
      ),
      child: const Text(
        'Turn walking into a habit that actually sticks — shared streaks make skipping harder.',
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.55),
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _billingToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.08),
        ),
      ),
      child: Row(
        children: [
          _billingTab('Monthly', 'monthly'),
          _billingTab('Yearly', 'yearly', showSave: true),
        ],
      ),
    );
  }

  Widget _billingTab(
    String label,
    String value, {
    bool showSave = false,
  }) {
    final selected = selectedBilling == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedBilling = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? const Color.fromRGBO(255, 255, 255, 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? const Color.fromRGBO(255, 255, 255, 0.95)
                      : const Color.fromRGBO(255, 255, 255, 0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showSave) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(46, 230, 166, 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Save 33%',
                    style: TextStyle(
                      color: Color(0xFF2EE6A6),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _ctaButton(String text) {
    return GestureDetector(
      onTap: loading ? null : _goToDashboard,
      child: Opacity(
        opacity: loading ? 0.6 : 1,
        child: Container(
          width: double.infinity,
          height: 48,
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
              loading ? 'Processing...' : text,
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.85),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBadge(String text, {required bool isGold}) {
    return Positioned(
      top: -12,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: LinearGradient(
              colors: isGold
                  ? const [
                      Color(0xFFFFB832),
                      Color(0xFFFF9500),
                    ]
                  : const [
                      Color(0xFF2EE6A6),
                      Color(0xFF1EC896),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: isGold
                    ? const Color.fromRGBO(255, 180, 50, 0.5)
                    : const Color.fromRGBO(46, 230, 166, 0.4),
                blurRadius: 15,
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.85),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _reassuranceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.04),
        ),
      ),
      child: const Text(
        'You can change your plan later.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          fontSize: 12,
        ),
      ),
    );
  }
}