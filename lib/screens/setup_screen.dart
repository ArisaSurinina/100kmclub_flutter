import 'package:flutter/material.dart';

import '../services/api_client.dart';
import '../services/auth_storage.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.personalGoalKm = 100,
    this.protectionsLeftYear = 2,
    this.onBack,
    this.onOpenAccountSettings,
    this.onViewRules,
    this.onChangeGoal,
    this.onActivateProtection,
    this.onOpenPoints,
    this.onOpenSubscription,
    this.onLogout,
  });

  final String name;
  final String email;
  final String? avatarUrl;
  final int personalGoalKm;
  final int protectionsLeftYear;

  final VoidCallback? onBack;
  final Future<void> Function()? onOpenAccountSettings;
  final VoidCallback? onViewRules;
  final VoidCallback? onChangeGoal;
  final VoidCallback? onActivateProtection;
  final VoidCallback? onOpenPoints;
  final VoidCallback? onOpenSubscription;
  final VoidCallback? onLogout;

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
late String _name;
late String _email;
String? _avatarUrl;
  static const Color pageTop = Color(0xFF1A1A1F);
  static const Color pageBottom = Color(0xFF16161A);
  static const Color cardBg = Color.fromRGBO(255, 255, 255, 0.02);
  static const Color cardBorder = Color.fromRGBO(255, 255, 255, 0.04);
  static const Color mutedText = Color.fromRGBO(255, 255, 255, 0.40);

  static const Color green = Color(0xFF2EE6A6);
  static const Color avatarGreen = Color(0xFF00FF94);
  static const Color orange = Color(0xFFFF9F43);
  static const Color purple = Color(0xFFA78BFA);
  static const Color purpleLight = Color(0xFFC4B5FD);
  static const Color yellow = Color(0xFFFFC107);
  static const Color gold = Color(0xFFFFB832);

  @override
void initState() {
  super.initState();
  _name = widget.name;
  _email = widget.email;
  _avatarUrl = widget.avatarUrl;
}

Future<void> _refreshUser() async {
  final user = await AuthStorage.readUser();

  if (!mounted || user == null) return;

  setState(() {
    _name = (user['name'] as String?) ?? _name;
    _email = (user['email'] as String?) ?? _email;
    _avatarUrl = user['avatar_url'] as String?;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBottom,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [pageTop, pageBottom],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              24,
              24,
              24,
              100 + MediaQuery.of(context).padding.bottom,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 512),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(onBack: widget.onBack),
                    const SizedBox(height: 24),
                    _ProfileCard(
                      name: _name,
                      email: _email,
                      avatarUrl: _avatarUrl,
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
  icon: Icons.settings_outlined,
  iconColor: Colors.white60,
  title: 'Account Settings',
  helper: 'Manage your personal information.',
  child: _NavRow(
    label: 'Open settings',
    backgroundColor:
        const Color.fromRGBO(255, 255, 255, 0.04),
    borderColor:
        const Color.fromRGBO(255, 255, 255, 0.08),
    onTap: () async {
      await widget.onOpenAccountSettings?.call();
      await _refreshUser();
    },
  ),
),
                    const SizedBox(height: 24),
                    _SectionCard(
                      icon: Icons.menu_book_outlined,
                      iconColor: orange,
                      title: 'How it works',
                      helper: 'Understand the rules of the system',
                      child: _NavRow(
                        label: 'View rules',
                        backgroundColor:
                            const Color.fromRGBO(255, 159, 67, 0.06),
                        borderColor:
                            const Color.fromRGBO(255, 159, 67, 0.15),
                        onTap: widget.onViewRules,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      icon: Icons.track_changes,
                      iconColor: green,
                      title: 'Monthly Goal (km)',
                      helper:
                          'Your personal target for planning. Challenge completion remains at 100 km.',
                      child: _GoalRow(
                        goalKm: widget.personalGoalKm,
                        onTap: widget.onChangeGoal,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      icon: Icons.shield_outlined,
                      iconColor: purple,
                      title: 'Life Happens',
                      helper:
                          'Protect your streak when life gets in the way. Use wisely - you get 2 per year.',
                      child: _LifeHappensCard(
                        protectionsLeftYear: widget.protectionsLeftYear,
                        onActivateProtection: widget.onActivateProtection,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      icon: Icons.star_border,
                      iconColor: yellow,
                      title: 'Points',
                      helper:
                          'Earn points for every walk and challenge completed.',
                      child: _NavRow(
                        label: 'Coming soon',
                        backgroundColor:
                            const Color.fromRGBO(255, 193, 7, 0.06),
                        borderColor:
                            const Color.fromRGBO(255, 193, 7, 0.12),
                        onTap: widget.onOpenPoints,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      icon: Icons.workspace_premium_outlined,
                      iconColor: gold,
                      title: 'Subscription',
                      helper: 'Commitment is stronger together.',
                      child: _NavRow(
                        label: 'Unlock full access',
                        backgroundColor:
                            const Color.fromRGBO(255, 184, 50, 0.06),
                        borderColor:
                            const Color.fromRGBO(255, 184, 50, 0.15),
                        onTap: () async {
  await widget.onOpenAccountSettings?.call();
  await _refreshUser();
},
                      ),
                    ),
                    const SizedBox(height: 24),
                    _LogoutButton(onTap: widget.onLogout),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onBack ?? () => Navigator.of(context).maybePop(),
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
          'Setup',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  final String name;
  final String email;
  final String? avatarUrl;

  String? _fullAvatarUrl() {
  if (avatarUrl == null || avatarUrl!.isEmpty) {
    return null;
  }

  if (avatarUrl!.startsWith('http://') ||
      avatarUrl!.startsWith('https://')) {
    return avatarUrl;
  }

  return '${ApiClient.backendBaseUrl}$avatarUrl';
}

  @override
  Widget build(BuildContext context) {
    final String initial = name.trim().isNotEmpty
        ? name.trim().characters.first.toUpperCase()
        : '?';

    return _GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: _SetupScreenState.avatarGreen,
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: _fullAvatarUrl() != null
    ? Image.network(
        _fullAvatarUrl()!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _AvatarInitial(initial),
                  )
                : _AvatarInitial(initial),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFA1A1AA),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarInitial extends StatelessWidget {
  const _AvatarInitial(this.initial);

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.helper,
    required this.child,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String helper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            helper,
            style: const TextStyle(
              color: _SetupScreenState.mutedText,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _SetupScreenState.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _SetupScreenState.cardBorder),
      ),
      child: child,
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.25,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 16,
                color: Color.fromRGBO(255, 255, 255, 0.40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  const _GoalRow({
    required this.goalKm,
    this.onTap,
  });

  final int goalKm;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(46, 230, 166, 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromRGBO(46, 230, 166, 0.20),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$goalKm km',
                  style: const TextStyle(
                    color: _SetupScreenState.green,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
              ),
              const Text(
                'Tap to change',
                style: TextStyle(
                  color: _SetupScreenState.mutedText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LifeHappensCard extends StatelessWidget {
  const _LifeHappensCard({
    required this.protectionsLeftYear,
    this.onActivateProtection,
  });

  final int protectionsLeftYear;
  final VoidCallback? onActivateProtection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(167, 139, 250, 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(167, 139, 250, 0.20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(167, 139, 250, 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  size: 24,
                  color: _SetupScreenState.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$protectionsLeftYear',
                      style: const TextStyle(
                        color: _SetupScreenState.purple,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'left this year',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.50),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: onActivateProtection,
              icon: const Icon(Icons.shield_outlined, size: 16),
              label: const Text('Activate Protection'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _SetupScreenState.purpleLight,
                backgroundColor: const Color.fromRGBO(167, 139, 250, 0.20),
                side: const BorderSide(
                  color: Color.fromRGBO(167, 139, 250, 0.35),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.logout, size: 18),
        label: const Text('Log Out'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),
          foregroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}