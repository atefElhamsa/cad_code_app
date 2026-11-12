import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_theme.dart';

class AuthFooterLink extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onTap;

  const AuthFooterLink({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveUtils.fontSize(
      context,
      16,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: normalText,
          style: TextStyle(
            color: Colors.white70,
            fontSize: fontSize,
            fontFamily: 'Inter',
          ),
          children: [
            TextSpan(
              text: linkText,
              style: TextStyle(
                color: AppTheme.primaryGoldLight,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
