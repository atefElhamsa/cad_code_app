import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final fieldHeight = context.isTablet ? 56.0 : 52.0;
    final fontSize = ResponsiveUtils.fontSize(
      context,
      16,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return SizedBox(
      height: fieldHeight,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Image.asset(
                'assets/images/google_logo.png',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
        label: Text(
          isLoading ? 'Please wait...' : 'Continue with Google',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, curve: Curves.easeOut);
  }
}
