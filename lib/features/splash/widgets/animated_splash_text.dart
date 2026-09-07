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
        if (entry.value == ' ') return Text(' ', style: style);

        return ShaderMask(
              shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                entry.value,
                style: style.copyWith(color: Colors.white),
              ),
            )
            .animate()
            .fadeIn(delay: (delayOffset + entry.key * 70).ms, duration: 400.ms)
            .slideY(
              begin: 0.8,
              end: 0,
              delay: (delayOffset + entry.key * 70).ms,
              duration: 500.ms,
              curve: Curves.easeOutBack,
            );
      }).toList(),
    );
  }
}
