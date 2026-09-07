import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text(
              'G',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      label: Text(
        isLoading ? 'Please wait...' : 'Continue with Google',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, curve: Curves.easeOut);
  }
}
