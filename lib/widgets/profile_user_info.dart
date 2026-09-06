import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class ProfileUserInfo extends StatelessWidget {
  final String name;
  final String phone;

  const ProfileUserInfo({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryCyan.withValues(alpha: 0.1),
          ),
          child: const Icon(Icons.person_rounded, color: AppTheme.primaryCyan, size: 72),
        ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 24),
        Text(
          name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDarkNavy,
            fontFamily: 'Inter',
          ),
        ).animate().fade(delay: 200.ms).slideY(begin: 0.2),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.call_rounded, color: Colors.green, size: 18),
              const SizedBox(width: 8),
              Text(
                phone,
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontFamily: 'Inter', fontSize: 14),
              ),
            ],
          ),
        ).animate().fade(delay: 300.ms).slideY(begin: 0.2),
      ],
    );
  }
}
