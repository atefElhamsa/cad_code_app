import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CcLogo extends StatelessWidget {
  final double size;

  const CcLogo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(size * 0.15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCyan.withValues(alpha: 0.3),
            blurRadius: size * 0.25,
            spreadRadius: size * 0.05,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.05),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(size * 0.10),
          ),
          child: Center(
            child: Text(
              'C',
              style: TextStyle(
                fontSize: size * 0.6,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryCyan,
                height: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
