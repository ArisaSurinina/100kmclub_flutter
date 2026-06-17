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
                _identityCard(context),
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
                _dangerCard(context),
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

void _showChangeGroupNameDialog(BuildContext context) {
  final controller = TextEditingController(text: 'ARI');

  showDialog(
    context: context,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.8),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 512),
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
                  onTap: () => Navigator.pop(dialogContext),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Change group name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Group name',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(255, 255, 255, 0.03),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 0.08),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(46, 230, 166, 0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => Navigator.pop(dialogContext),
                    child: _modalGreenButton('Save'),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.pop(dialogContext),
                    child: _modalCancelButton('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showLeaveGroupDialog(BuildContext context) {
  final controller = TextEditingController();

  showDialog(
    context: context,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.8),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 512),
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
                  onTap: () => Navigator.pop(dialogContext),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Leave group',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Type the group name to confirm.',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    autofocus: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Realskies 🇱🇹 💩💨🌙...',
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(dialogContext),
                          child: _modalCancelButton('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(dialogContext),
                          child: _modalDangerButton('Leave group'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _modalGreenButton(String text) {
  return Container(
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

Widget _modalCancelButton(String text) {
  return Container(
    width: double.infinity,
    height: 48,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(255, 255, 255, 0.05),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color.fromRGBO(255, 255, 255, 0.1),
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget _modalDangerButton(String text) {
  return Container(
    width: double.infinity,
    height: 48,
    decoration: BoxDecoration(
      color: const Color(0xFFEF4444),
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.2),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.logout,
          color: Colors.white,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
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

  Widget _identityCard(BuildContext context) {
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
          onTap: () {
            _showChangeGroupNameDialog(context);
          },
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

  Widget _dangerCard(BuildContext context) {
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
        _leaveGroupButton(
          onTap: () {
            _showLeaveGroupDialog(context);
          },
        ),
      ],
    ),
  );
}

  Widget _settingsRow({
  required IconData icon,
  required String text,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
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

  Widget _leaveGroupButton({
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
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