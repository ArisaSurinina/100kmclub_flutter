import 'package:flutter/material.dart';
import 'group_settings_screen.dart';

class ActiveGroupScreen extends StatelessWidget {
  const ActiveGroupScreen({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                const SizedBox(height: 24),
                _groupPhoto(),
                const SizedBox(height: 24),
                _statsRow(),
                const SizedBox(height: 24),
                _membersSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Realskies 🇱🇹 💩💨🌙...',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(46, 230, 166, 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Color(0xFF2EE6A6),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '1 members',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GroupSettingsScreen(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.settings_outlined,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _groupPhoto() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.06),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1200',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.local_fire_department,
            iconColor: const Color(0xFFFFB832),
            value: '0',
            label: 'Group Streak',
            valueColor: const Color(0xFFFFB832),
            bgColor: const Color.fromRGBO(255, 184, 50, 0.08),
            borderColor: const Color.fromRGBO(255, 184, 50, 0.15),
            valueSize: 30,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.access_time,
            iconColor: const Color.fromRGBO(255, 255, 255, 0.5),
            value: 'New group',
            label: 'Group Age',
            valueColor: const Color.fromRGBO(255, 255, 255, 0.7),
            bgColor: const Color.fromRGBO(255, 255, 255, 0.03),
            borderColor: const Color.fromRGBO(255, 255, 255, 0.06),
            valueSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required Color valueColor,
    required Color bgColor,
    required Color borderColor,
    required double valueSize,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: valueColor,
              fontSize: valueSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: label == 'Group Streak'
                  ? const Color.fromRGBO(255, 255, 255, 0.5)
                  : const Color.fromRGBO(255, 255, 255, 0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _membersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.groups_2_outlined,
              color: Color.fromRGBO(255, 255, 255, 0.6),
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '(1)',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _memberCard(),
      ],
    );
  }

  Widget _memberCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF27272A),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Arisa Surinina',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '(you)',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'In progress',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '44.7 km',
                style: TextStyle(
                  color: Color(0xFF2EE6A6),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'this month',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}