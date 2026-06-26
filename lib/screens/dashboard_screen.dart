import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'setup_screen.dart';
import 'account_settings_screen.dart';
import 'forming_group_screen.dart';
import 'debug_panel_screen.dart';

import '../services/auth_storage.dart';
import 'auth_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<DebugWalk> _debugWalks = [];
double _debugCurrentKm = 24.0;

  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AuthStorage.readUser();

    if (!mounted) return;

    debugPrint('DASHBOARD USER AVATAR URL: ${user?['avatar_url']}');

setState(() {
  _user = user;
});
  }
  
  void _showCreateGroupDialog() {
  showDialog(
    context: context,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.8),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 512,
            maxHeight: 620,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F10),
            border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                  ),
                ),
              ),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Create Group',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Group Name',
                      style: TextStyle(
                        color: Color(0xFFA1A1AA),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: _inputDecoration('Morning Walkers'),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(46, 230, 166, 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromRGBO(46, 230, 166, 0.15),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: Color(0xFF2EE6A6),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Groups are commitment contracts. Once locked, all members share responsibility for the streak.',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FormingGroupScreen(),
                          ),
                        );
                      },
                      child: _greenButton('Create Group'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  static InputDecoration _inputDecoration(String hint) {
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
    );
  }

  static Widget _greenButton(String text) {
    return Container(
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
          ),
        ),
      ),
    );
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
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            child: Column(
              children: [
                _header(),
                const SizedBox(height: 20),
                _divider(),
                const SizedBox(height: 24),
                Center(
  child: ProgressRing(
    current: _debugCurrentKm,
    target: 100.0,
  ),
),
                const SizedBox(height: 32),
                _actionButtons(),
                const SizedBox(height: 32),
                _statsRow(),
                const SizedBox(height: 40),
                _groupsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Monthly Challenge',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.35),
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
  children: [
    _pointsPill(),
    const SizedBox(width: 8),
    _streakPill(),
    if (kDebugMode) ...[
      const SizedBox(width: 8),
      GestureDetector(
        onTap: () async {
  final debugWalks = await Navigator.push<List<DebugWalk>>(
    context,
    MaterialPageRoute(
      builder: (context) => DebugPanelScreen(
  initialWalks: _debugWalks,
),
    ),
  );

  if (debugWalks != null) {
    setState(() {
      _debugWalks
        ..clear()
        ..addAll(debugWalks);

      _debugCurrentKm = _debugWalks.fold(
        0,
        (sum, walk) => sum + walk.distanceKm,
      );
    });
  }
},
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 107, 107, 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color.fromRGBO(255, 107, 107, 0.5),
              style: BorderStyle.solid,
            ),
          ),
          child: const Icon(
            Icons.bug_report_outlined,
            size: 16,
            color: Color(0xFFFF6B6B),
          ),
        ),
      ),
    ],
    const SizedBox(width: 8),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetupScreen(
  name: (_user?['name'] as String?) ?? 'User',
  email: (_user?['email'] as String?) ?? '',
  avatarUrl: _user?['avatar_url'] as String?,
          personalGoalKm: 100,
          protectionsLeftYear: 2,
          onBack: () => Navigator.pop(context),
          onOpenAccountSettings: () async {
  await Navigator.of(context).push(
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        AccountSettingsScreen(
      name: (_user?['name'] as String?) ?? 'User',
      email: (_user?['email'] as String?) ?? '',
      avatarUrl: _user?['avatar_url'] as String?,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);

  await _loadUser();
},
          onViewRules: () {},
          onChangeGoal: () {},
          onActivateProtection: () {},
          onOpenPoints: () {},
          onOpenSubscription: () {},
          onLogout: () async {
  await AuthStorage.clearAuth();

  if (!context.mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const AuthScreen(),
    ),
    (route) => false,
  );
},
        ),
      ),
    );
  },
  child: const Icon(
    Icons.logout,
    size: 16,
    color: Color.fromRGBO(255, 255, 255, 0.25),
  ),
),
          ],
        ),
      ],
    );
  }

  Widget _pointsPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(46, 230, 166, 0.3),
        ),
        gradient: const RadialGradient(
          colors: [
            Color.fromRGBO(46, 230, 166, 0.15),
            Color.fromRGBO(20, 18, 12, 0.85),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(46, 230, 166, 0.2),
            blurRadius: 20,
          ),
        ],
      ),
      child: const Text(
        '0 pts',
        style: TextStyle(
          color: Color(0xFF2EE6A6),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _streakPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(255, 200, 50, 0.3),
        ),
        gradient: const RadialGradient(
          colors: [
            Color.fromRGBO(255, 200, 50, 0.15),
            Color.fromRGBO(20, 18, 12, 0.85),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 200, 50, 0.25),
            blurRadius: 20,
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(
            Icons.local_fire_department,
            size: 14,
            color: Color(0xFFFFB830),
          ),
          SizedBox(width: 6),
          Text(
            '0m',
            style: TextStyle(
              color: Color(0xFFF5C842),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
            Color.fromRGBO(255, 255, 255, 0.04),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: Icons.location_on_outlined,
            text: 'Start Walk',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(
            icon: Icons.history,
            text: 'My Walks',
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
  }) {
    return Container(
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
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color.fromRGBO(0, 0, 0, 0.85),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.85),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow() {
  final now = DateTime.now();
  final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  final daysLeft = lastDayOfMonth.day - now.day + 1;

  final kmLeft = math.max(0.0, 100.0 - _debugCurrentKm);
  final kmPerDay = daysLeft > 0 ? kmLeft / daysLeft : 0.0;

  return Row(
    children: [
      Expanded(
        child: StatCard(
          value: kmLeft.toStringAsFixed(1),
          label: 'km left',
          color: const Color.fromRGBO(115, 180, 255, 1),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          value: '$daysLeft',
          label: 'days left',
          color: const Color.fromRGBO(110, 175, 250, 1),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: StatCard(
          value: kmPerDay.toStringAsFixed(1),
          label: 'km/day',
          color: const Color.fromRGBO(105, 170, 248, 1),
        ),
      ),
    ],
  );
}

  Widget _groupsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Groups',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.85),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Turn your walks into a habit together.',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.35),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: _showCreateGroupDialog,
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.85),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Create group',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.02),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.04),
            ),
          ),
          child: const Center(
            child: Text(
              'You have not joined any groups yet',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.04),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.24,
              shadows: const [
                Shadow(
                  color: Color.fromRGBO(96, 165, 250, 0.15),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.4),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.22,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressRing extends StatelessWidget {
  final double current;
  final double target;

  const ProgressRing({
    super.key,
    required this.current,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 270,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(270, 270),
            painter: ProgressRingPainter(
              current: current,
              target: target,
              glow: true,
            ),
          ),
          CustomPaint(
            size: const Size(230, 230),
            painter: ProgressRingPainter(
              current: current,
              target: target,
              glow: false,
            ),
          ),
          Column(
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
                child: Text(
                  current.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.92,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'of ${target.toStringAsFixed(0)} km',
                style: const TextStyle(
                  color: Color.fromRGBO(160, 166, 172, 0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressRingPainter extends CustomPainter {
  final double current;
  final double target;
  final bool glow;

  ProgressRingPainter({
    required this.current,
    required this.target,
    required this.glow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final progress = (current / target).clamp(0.0, 1.0);
    final strokeWidth = glow ? 16.0 : 12.0;
    final radius = 109.0;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    if (!glow) {
      final backgroundPaint = Paint()
        ..color = const Color.fromRGBO(255, 255, 255, 0.06)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final progressPaint = Paint()
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: [
          Color(0xFF2EE6A6),
          Color(0xFFFFD166),
          Color(0xFFFF8A50),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (glow) {
      progressPaint.maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        22,
      );
    }

    canvas.drawArc(
      rect,
      -math.pi / 2,
      progress * math.pi * 2,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressRingPainter oldDelegate) {
    return oldDelegate.current != current ||
        oldDelegate.target != target ||
        oldDelegate.glow != glow;
  }
}