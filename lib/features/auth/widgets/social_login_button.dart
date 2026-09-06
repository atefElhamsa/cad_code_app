import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: const Text('G', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
      label: const Text('Continue with Google', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, curve: Curves.easeOut);
  }
}
