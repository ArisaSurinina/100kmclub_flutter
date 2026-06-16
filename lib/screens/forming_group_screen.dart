import 'package:flutter/material.dart';

class FormingGroupScreen extends StatefulWidget {
  const FormingGroupScreen({super.key});

  @override
  State<FormingGroupScreen> createState() => _FormingGroupScreenState();
}

class _FormingGroupScreenState extends State<FormingGroupScreen> {
  final TextEditingController _lockController = TextEditingController();
  bool showLeaveConfirm = false;

  @override
  void dispose() {
    _lockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const groupName = '4';

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
                _header(groupName),
                const SizedBox(height: 24),
                _formingCard(groupName),
                const SizedBox(height: 24),
                _membersSection(),
                if (showLeaveConfirm) ...[
                  const SizedBox(height: 24),
                  _leaveConfirmCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(String groupName) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
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
              Text(
                groupName,
                style: const TextStyle(
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
                      color: const Color.fromRGBO(255, 180, 50, 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Forming',
                      style: TextStyle(
                        color: Color(0xFFFFB832),
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
      ],
    );
  }

  Widget _formingCard(String groupName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 180, 50, 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(255, 180, 50, 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 180, 50, 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Color(0xFFFFB832),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Group is Forming',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Add members, then lock to activate. Once locked, membership is permanent.',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: const Color.fromRGBO(255, 180, 50, 0.15),
          ),
          const SizedBox(height: 16),
          const Text(
            'Lock Group',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: 12,
              ),
              children: [
                const TextSpan(text: 'Type "'),
                TextSpan(
                  text: groupName,
                  style: const TextStyle(
                    color: Color(0xFFFFB832),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(text: '" to confirm and lock'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _input('Enter group name to confirm'),
              ),
              const SizedBox(width: 8),
              _lockButton(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _outlineButton(
                  icon: Icons.person_add_alt_1,
                  text: 'Add Member',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _leaveButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _input(String hint) {
    return TextField(
      controller: _lockController,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
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
      ),
    );
  }

  Widget _lockButton() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            Icons.lock_outline,
            color: Color.fromRGBO(0, 0, 0, 0.85),
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            'Lock',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.85),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlineButton({
    required IconData icon,
    required String text,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
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

  Widget _leaveButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showLeaveConfirm = true;
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(239, 68, 68, 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color.fromRGBO(239, 68, 68, 0.2),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              color: Color.fromRGBO(239, 68, 68, 0.8),
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              'Leave',
              style: TextStyle(
                color: Color.fromRGBO(239, 68, 68, 0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _membersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.group_outlined,
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
            SizedBox(width: 6),
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
        Container(
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
                child: Row(
                  children: [
                    Text(
                      'Arisa Surinina',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _leaveConfirmCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(239, 68, 68, 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(239, 68, 68, 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Are you sure you want to leave this group?',
            style: TextStyle(
              color: Color(0xFFFCA5A5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 68, 68, 0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Confirm Leave',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showLeaveConfirm = false;
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}