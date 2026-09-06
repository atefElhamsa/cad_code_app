import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ProfileProgressRow extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const ProfileProgressRow({
    super.key,
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: percentage),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.textDarkNavy,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    '${(value * 100).toInt()}%',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: value,
                backgroundColor: color.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation(color),
                minHeight: 10,
                borderRadius: BorderRadius.circular(100),
              ),
            ],
          );
        },
      ),
    );
  }
}
