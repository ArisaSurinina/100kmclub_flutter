import 'package:flutter/material.dart';

class DebugPanelScreen extends StatefulWidget {
  final List<DebugWalk> initialWalks;

  const DebugPanelScreen({
    super.key,
    this.initialWalks = const [],
  });

  @override
  State<DebugPanelScreen> createState() => _DebugPanelScreenState();
}

class _DebugPanelScreenState extends State<DebugPanelScreen> {
  final TextEditingController _distanceController =
      TextEditingController(text: '5.0');

  final TextEditingController _durationController =
      TextEditingController(text: '60');

  final TextEditingController _dateController =
      TextEditingController();

  late final List<DebugWalk> _walks;

  String get _timezone => DateTime.now().timeZoneName;

  double get _totalKm {
    return _walks.fold(0, (sum, walk) => sum + walk.distanceKm);
  }

  double get _kmLeft {
    final left = 100 - _totalKm;
    return left < 0 ? 0 : left;
  }

  bool get _goalCompleted => _totalKm >= 100;

  @override
  void initState() {
    super.initState();
    _walks = List<DebugWalk>.from(widget.initialWalks);
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _durationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _addDebugWalk() {
    final distanceText =
        _distanceController.text.replaceAll(',', '.');

    final durationText =
        _durationController.text;

    final distance =
        double.tryParse(distanceText);

    final duration =
        int.tryParse(durationText);

    if (distance == null || distance <= 0) {
      return;
    }

    if (duration == null || duration < 0) {
      return;
    }

    final now = DateTime.now();

    setState(() {
      _walks.insert(
        0,
        DebugWalk(
          distanceKm: distance,
          durationMinutes: duration,
          date: _dateController.text.trim().isEmpty
              ? now
              : DateTime.tryParse(
                      _dateController.text.trim(),
                    ) ??
                  now,
        ),
      );
    });
  }

  void _clearDebugWalks() {
    setState(() {
      _walks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                  const SizedBox(height: 16),
                  _warningBanner(),
                  const SizedBox(height: 16),
                  _summarySection(),
                  const SizedBox(height: 16),
                  _createWalkSection(),
                  const SizedBox(height: 16),
                  _walksSection(),
                  const SizedBox(height: 16),
                  _debugInfoSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context, _walks),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF555555),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              '🧪 Walk Test Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'monospace',
              ),
            ),
          ),
          GestureDetector(
            onTap: _clearDebugWalks,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF555555),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _warningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFF856404),
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'INTERNAL TESTING ONLY - Not for production',
              style: TextStyle(
                color: Color(0xFF856404),
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summarySection() {
    return _section(
      title: '📈 Debug Summary',
      child: Column(
        children: [
          _summaryRow('Total KM', '${_totalKm.toStringAsFixed(1)} km'),
          _summaryRow('Goal', '100 km'),
          _summaryRow('Goal Reached', _goalCompleted ? '✅ true' : '❌ false'),
          _summaryRow('KM Left', '${_kmLeft.toStringAsFixed(1)} km'),
          _summaryRow('Total Walks', '${_walks.length}'),
        ],
      ),
    );
  }

  Widget _createWalkSection() {
    return _section(
      title: '1️⃣ Create Test Walk',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _inputBlock(
                label: 'Distance (km)',
                controller: _distanceController,
                hint: 'e.g. 6.78 or 6,78',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              _inputBlock(
                label: 'Duration (min)',
                controller: _durationController,
                hint: '60',
                keyboardType: TextInputType.number,
              ),
              Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    _inputBlock(
      label: 'Started At',
      controller: _dateController,
      hint: 'YYYY-MM-DD or leave empty',
    ),
    const SizedBox(height: 6),
    GestureDetector(
      onTap: () {
        final now = DateTime.now();
        _dateController.text =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF6C757D),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'Use Today',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ),
    ),
  ],
),
              _readonlyBox(
                label: 'Timezone',
                value: _timezone,
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _addDebugWalk,
            child: _primaryButton('Create Walk'),
          ),
          const SizedBox(height: 8),
          const Text(
            'Creates local fake walks only. No API calls.',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 11,
              fontStyle: FontStyle.italic,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _walksSection() {
    return _section(
      title: '2️⃣ Debug Walks (${_walks.length})',
      child: _walks.isEmpty
          ? _emptyState('No debug walks found')
          : Column(
              children: _walks.map((walk) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFFDDDDDD),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${walk.distanceKm.toStringAsFixed(1)} km',
                          style: const TextStyle(
                            color: Color(0xFF222222),
                            fontFamily: 'monospace',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${walk.durationMinutes} min',
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${walk.date.year}-${walk.date.month.toString().padLeft(2, '0')}-${walk.date.day.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _debugInfoSection() {
    final now = DateTime.now();

    return _section(
      title: '🔧 Debug Info',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Timezone: $_timezone\n'
          'Current Time: ${now.toIso8601String()}\n'
          'Local Time: ${now.toLocal()}',
          style: const TextStyle(
            color: Color(0xFF00FF00),
            fontSize: 12,
            height: 1.8,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 16,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            color: const Color(0xFFEEEEEE),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0F2FE),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF444444),
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBlock({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 14,
              fontFamily: 'monospace',
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 13,
                fontFamily: 'monospace',
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF999999),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF007BFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _readonlyBox({
    required String label,
    required String value,
  }) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFFDDDDDD),
              ),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF007BFF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _emptyState(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          style: BorderStyle.solid,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF666666),
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class DebugWalk {
  final double distanceKm;
  final int durationMinutes;
  final DateTime date;

  const DebugWalk({
    required this.distanceKm,
    required this.durationMinutes,
    required this.date,
  });
}