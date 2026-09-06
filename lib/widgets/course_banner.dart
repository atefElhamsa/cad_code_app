import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class CourseBanner extends StatelessWidget {
  final String title;
  final List<String> outcomes;
  final double progress;
  final String level;

  const CourseBanner({
    super.key,
    required this.title,
    required this.outcomes,
    this.progress = 0.0,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.primaryCyan,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primaryCyan),
                ),
                child: Text(
                  level,
                  style: const TextStyle(
                    color: AppTheme.primaryCyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...outcomes.map(
            (o) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryCyan,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(o, style: const TextStyle(color: AppTheme.textDarkNavy)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.backgroundLight,
            valueColor: const AlwaysStoppedAnimation(AppTheme.primaryCyan),
          ),
        ],
      ),
    );
  }
}
