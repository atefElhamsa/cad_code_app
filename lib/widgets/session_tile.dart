import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class SessionTile extends StatelessWidget {
  final String title;
  final String duration;
  final VoidCallback onPlay;

  const SessionTile({
    super.key,
    required this.title,
    required this.duration,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onPlay,
            borderRadius: BorderRadius.circular(20),
            splashColor: AppTheme.primaryCyan.withValues(alpha: 0.08),
            highlightColor: AppTheme.primaryCyan.withValues(alpha: 0.04),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Play button
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryCyan,
                          AppTheme.primaryCyan.withValues(alpha: 0.75),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryCyan.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title + duration
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: AppTheme.textDarkNavy,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 13,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Arrow indicator
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Color(0xFFB0B0B0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
