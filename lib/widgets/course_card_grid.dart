import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CourseCardGrid extends StatelessWidget {
  final String title;
  final String tag;
  final VoidCallback onTap;
  final String? imageUrl;

  const CourseCardGrid({
    super.key,
    required this.title,
    required this.tag,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundDarkNavy,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.primaryGoldLight.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Dark gradient overlay for readability and premium feel
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.0, 0.4, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Bottom Content: Title and Action Button
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Premium Action Button
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.goldGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGoldDark.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
