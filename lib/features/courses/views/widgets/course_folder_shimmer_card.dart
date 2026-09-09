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
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 24,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundDarkNavy.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundDarkNavy.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 48,
                        width: 140,
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundDarkNavy.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          color: AppTheme.backgroundDarkNavy.withValues(alpha: 0.05),
          angle: 0.5,
        );
  }
}
