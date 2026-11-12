import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class CourseFolderShimmerCard extends StatelessWidget {
  const CourseFolderShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row: Chapter Badge + Status Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 26,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 90,
                height: 26,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Title Shimmer Line
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 22,
              width: 180,
              decoration: BoxDecoration(
                color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Description Line 1
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),

          // Description Line 2
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 14,
              width: 220,
              decoration: BoxDecoration(
                color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Bottom Action Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 84,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              Container(
                width: 105,
                height: 42,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          color: AppTheme.primaryGoldLight.withValues(alpha: 0.15),
          angle: 0.5,
        );
  }
}
