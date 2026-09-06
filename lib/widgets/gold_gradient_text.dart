import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class PrimaryGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const PrimaryGradientText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: Colors.white),
      ),
    );
  }
}
