import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class AnimatedSplashText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int delayOffset;

  const AnimatedSplashText({
    super.key,
    required this.text,
    required this.style,
    required this.delayOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: text.split('').asMap().entries.map((entry) {
        if (entry.value == ' ') {
          return Text(' ', style: style);
        }

        return Text(
          entry.value,
          style: style.copyWith(
            color: AppTheme.primaryGoldLight,
            height: 1.2,
          ),
        )
            .animate()
            .slideY(
              begin: 0.35,
              end: 0,
              delay: (delayOffset + entry.key * 55).ms,
              duration: 420.ms,
              curve: Curves.easeOutCubic,
            );
      }).toList(),
    );
  }
}
