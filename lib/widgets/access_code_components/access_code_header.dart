import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AccessCodeHeader extends StatelessWidget {
  const AccessCodeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Premium Lock Icon
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.backgroundDarkNavy,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_outline_rounded,
            color: AppTheme.primaryGoldLight,
            size: 36,
          ),
        ),
        const SizedBox(height: 24),

        // Title
        const Text(
          'Enter Access Code',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDarkNavy,
            fontFamily: 'Inter',
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),

        // Subtitle
        Text(
          "If you've enrolled offline at our course center,\nplease enter the access code you were given.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textDarkNavy.withValues(alpha: 0.6),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
