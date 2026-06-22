import 'package:flutter/material.dart';

enum AppSnackBarType {
  success,
  error,
  warning,
  info,
}

class AppSnackBar {
  static void success(BuildContext context, String message) {
    _show(context, message, AppSnackBarType.success);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, AppSnackBarType.error);
  }

  static void warning(BuildContext context, String message) {
    _show(context, message, AppSnackBarType.warning);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, AppSnackBarType.info);
  }

  static void _show(
    BuildContext context,
    String message,
    AppSnackBarType type,
  ) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) {
        return _AppSnackBarOverlay(
          message: message,
          type: type,
        );
      },
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 4), () {
      entry.remove();
    });
  }
}

class _AppSnackBarOverlay extends StatelessWidget {
  const _AppSnackBarOverlay({
    required this.message,
    required this.type,
  });

  final String message;
  final AppSnackBarType type;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(type);

    return Positioned(
      top: MediaQuery.of(context).padding.top + 32,
      left: 16,
      right: 16,
      child: SafeArea(
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 356),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: style.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: style.borderColor),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    style.icon,
                    size: 20,
                    color: style.iconColor,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: style.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _AppSnackBarStyle _styleFor(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return const _AppSnackBarStyle(
          backgroundColor: Color(0xFFEAFBF1),
          borderColor: Color(0xFFB7E8C8),
          iconColor: Color(0xFF138A3D),
          textColor: Color(0xFF137333),
          icon: Icons.check_circle,
        );
      case AppSnackBarType.error:
        return const _AppSnackBarStyle(
          backgroundColor: Color(0xFFFDECEC),
          borderColor: Color(0xFFF4B8B8),
          iconColor: Color(0xFFD93025),
          textColor: Color(0xFF9F1C16),
          icon: Icons.cancel,
        );
      case AppSnackBarType.warning:
        return const _AppSnackBarStyle(
          backgroundColor: Color(0xFFFFF7E6),
          borderColor: Color(0xFFFFD580),
          iconColor: Color(0xFFB26A00),
          textColor: Color(0xFF8A4B00),
          icon: Icons.warning_rounded,
        );
      case AppSnackBarType.info:
        return const _AppSnackBarStyle(
          backgroundColor: Color(0xFFEAF3FF),
          borderColor: Color(0xFFB7D4F5),
          iconColor: Color(0xFF1A73E8),
          textColor: Color(0xFF174EA6),
          icon: Icons.info,
        );
    }
  }
}

class _AppSnackBarStyle {
  const _AppSnackBarStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final IconData icon;
}