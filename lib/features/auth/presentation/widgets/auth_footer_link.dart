import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return TextButton(
      onPressed: onTap,
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
          children: [
            TextSpan(
              text: linkText,
              style: const TextStyle(
                color: AppTheme.primaryGoldLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
