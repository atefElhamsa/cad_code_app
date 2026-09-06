import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final double progress;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 4,
                backgroundColor: AppTheme.primaryCyan.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryCyan,
                ),
              ),
            ),
            CircleAvatar(
              radius: 42,
              backgroundColor: AppTheme.backgroundLight,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 32,
                  color: AppTheme.textDarkNavy,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDarkNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
