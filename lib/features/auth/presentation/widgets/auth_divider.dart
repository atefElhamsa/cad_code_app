import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.2))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: TextStyle(color: Colors.white54),
          ),
        ),
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.2))),
      ],
    ).animate().fadeIn(delay: 650.ms);
  }
}
