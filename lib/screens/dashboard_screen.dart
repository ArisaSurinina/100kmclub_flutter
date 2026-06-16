 import 'dart:math' as math;
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Group'),
          content: const Text('Test Modal'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            children: [
              _header(context),
              const SizedBox(height: 20),
              _divider(),
              const SizedBox(height: 24),
              const Center(
                child: ProgressRing(
                  current: 5.0,
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
    );
  }

  Widget _header(BuildContext context) {
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
            const SizedBox(height: 6),
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
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(
                Icons.logout,
                size: 18,
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
          fontWeight: FontWeight.w700,
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
            size: 16,
            color: Color(0xFFFFB830),
          ),
          SizedBox(width: 6),
          Text(
            '0m',
            style: TextStyle(
              color: Color(0xFFF5C842),
              fontSize: 13,
              fontWeight: FontWeight.w600,
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
          child: _primaryButton(
            icon: Icons.location_on_outlined,
            text: 'Start Walk',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _primaryButton(
            icon: Icons.history,
            text: 'My Walks',
          ),
        ),
      ],
    );
  }

  Widget _primaryButton({
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
            size: 18,
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
    return const Row(
      children: [
        Expanded(
          child: StatBox(
            value: '95.0',
            label: 'km left',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatBox(
            value: '15',
            label: 'days left',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatBox(
            value: '6.3',
            label: 'km/day',
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
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
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
                    size: 20,
                    color: Color.fromRGBO(0, 0, 0, 0.85),
                  ),
                  SizedBox(width: 8),
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

class StatBox extends StatelessWidget {
  final String value;
  final String label;

  const StatBox({
    super.key,
    required this.value,
    required this.label,
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
            style: const TextStyle(
              color: Color.fromRGBO(115, 180, 255, 1),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.4),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
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
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.9,
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
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = glow ? 0 : strokeWidth
      ..strokeCap = StrokeCap.round;

    if (!glow) {
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final gradient = const SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: math.pi * 1.5,
      colors: [
        Color(0xFF2EE6A6),
        Color(0xFFFFD166),
        Color(0xFFFF8A50),
      ],
      stops: [0.0, 0.5, 1.0],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (glow) {
      progressPaint
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22)
        ..color = const Color.fromRGBO(46, 230, 166, 0.28);
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
