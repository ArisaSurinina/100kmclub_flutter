import 'package:flutter/material.dart';

class GroupSettingsScreen extends StatelessWidget {
  const GroupSettingsScreen({super.key});

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
                _sectionTitle('GROUP IDENTITY'),
                const SizedBox(height: 12),
                _identityCard(),
                const SizedBox(height: 24),
                _sectionTitle('RULES'),
                const SizedBox(height: 12),
                _rulesCard(),
                const SizedBox(height: 24),
                _sectionTitle(
                  'DANGER ZONE',
                  color: Color.fromRGBO(239, 68, 68, 0.6),
                ),
                const SizedBox(height: 12),
                _dangerCard(),
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
        const Text(
          'Group Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(
    String text, {
    Color color = const Color.fromRGBO(255, 255, 255, 0.4),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _identityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _outerCardDecoration(),
      child: Column(
        children: [
          _settingsRow(
            icon: Icons.photo_camera_outlined,
            text: 'Change group photo',
          ),
          const SizedBox(height: 16),
          _photoPreview(),
          const SizedBox(height: 12),
          _removePhotoButton(),
          const SizedBox(height: 16),
          _settingsRow(
            icon: Icons.edit_outlined,
            text: 'Change group name',
          ),
        ],
      ),
    );
  }

  Widget _rulesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _outerCardDecoration(),
      child: _settingsRow(
        icon: Icons.menu_book_outlined,
        text: 'View rules',
      ),
    );
  }

  Widget _dangerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Leaving this group will dissolve it.',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.75),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'This action cannot be undone.',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.45),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          _leaveGroupButton(),
        ],
      ),
    );
  }

  Widget _settingsRow({
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromRGBO(255, 255, 255, 0.55),
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.7),
                fontSize: 14,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color.fromRGBO(255, 255, 255, 0.2),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _photoPreview() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.06),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _removePhotoButton() {
    return const Row(
      children: [
        Icon(
          Icons.delete_outline,
          color: Color.fromRGBO(239, 68, 68, 0.85),
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          'Remove photo',
          style: TextStyle(
            color: Color.fromRGBO(239, 68, 68, 0.85),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _leaveGroupButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(239, 68, 68, 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(239, 68, 68, 0.18),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.logout,
            color: Color.fromRGBO(239, 68, 68, 0.85),
            size: 18,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Leave group',
              style: TextStyle(
                color: Color.fromRGBO(239, 68, 68, 0.85),
                fontSize: 14,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Color.fromRGBO(239, 68, 68, 0.35),
            size: 20,
          ),
        ],
      ),
    );
  }

  BoxDecoration _outerCardDecoration() {
    return BoxDecoration(
      color: const Color.fromRGBO(255, 255, 255, 0.02),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color.fromRGBO(255, 255, 255, 0.04),
      ),
    );
  }
}