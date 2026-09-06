import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String status; // Pending, Submitted, Reviewed
  final VoidCallback onUpload;

  const TaskTile({
    super.key,
    required this.title,
    required this.status,
    required this.onUpload,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.blue;
      case 'reviewed':
        return const Color(0xFF4CAF50); // Green
      case 'pending':
        return const Color(0xFFF57C00); // Orange
      default:
        return AppTheme.primaryCyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFFFDF7E6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.assignment_rounded,
                color: Color(0xFFB8860B),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Texts and Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppTheme.textDarkNavy,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getStatusColor(),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Action Button or Status Icon
          if (status.toLowerCase() == 'pending')
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cloud_upload_rounded,
                  color: AppTheme.primaryCyan,
                  size: 22,
                ),
              ),
              onPressed: onUpload,
              splashRadius: 24,
            )
          else if (status.toLowerCase() == 'reviewed')
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF4CAF50),
                size: 28,
              ),
            )
          else if (status.toLowerCase() == 'submitted')
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.hourglass_bottom_rounded,
                color: Colors.blue,
                size: 28,
              ),
            ),
        ],
      ),
    );
  }
}
