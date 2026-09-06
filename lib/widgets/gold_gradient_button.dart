import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool outlined;

  const PrimaryGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        splashColor: AppTheme.primaryGoldLight.withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          decoration: BoxDecoration(
            gradient: outlined
                ? null
                : AppTheme.goldGradient, // Actually use Gold!
            color: outlined ? Colors.transparent : null,
            borderRadius: BorderRadius.circular(16),
            border: outlined
                ? Border.all(color: AppTheme.primaryGoldLight, width: 2)
                : null,
            boxShadow: outlined
                ? []
                : [
                    BoxShadow(
                      color: AppTheme.primaryGoldDark.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: outlined
                      ? AppTheme.primaryGoldLight
                      : AppTheme.textDarkNavy,
                  size: 24,
                ),
                const SizedBox(width: 12),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 18, // Slightly larger
                  fontWeight: FontWeight.w900,
                  color: outlined
                      ? AppTheme.primaryGoldLight
                      : AppTheme
                            .textDarkNavy, // Dark Navy on gold for max contrast
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
