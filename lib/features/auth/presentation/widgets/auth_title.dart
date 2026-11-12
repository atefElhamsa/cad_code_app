import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/responsive/responsive.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      28,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final subtitleFontSize = ResponsiveUtils.fontSize(
      context,
      16,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return Column(
      children: [
        Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 200.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
        const SizedBox(height: 8),
        Text(
              subtitle,
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: Colors.white.withValues(alpha: 0.6),
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 300.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
      ],
    );
  }
}
