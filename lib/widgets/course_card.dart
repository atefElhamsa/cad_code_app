import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String topic;
  final bool isLocked;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.topic,
    this.isLocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primaryCyan.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppTheme.primaryCyan.withOpacity(0.3),
                ),
              ),
              child: Icon(
                isLocked ? Icons.lock : Icons.book,
                color: AppTheme.primaryCyan,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDarkNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Learn basics of $topic',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textDarkNavy,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.primaryCyan.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
