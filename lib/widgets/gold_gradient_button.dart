import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool isLoading;

  const PrimaryGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.outlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(16),
        splashColor: AppTheme.primaryGoldLight.withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          decoration: BoxDecoration(
            gradient: outlined || isLoading ? null : AppTheme.goldGradient,
            color: outlined || isLoading
                ? (isLoading ? Colors.grey.shade800 : Colors.transparent)
                : null,
            borderRadius: BorderRadius.circular(16),
            border: outlined && !isLoading
                ? Border.all(color: AppTheme.primaryGoldLight, width: 2)
                : null,
            boxShadow: outlined || isLoading
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
              if (isLoading) ...[
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 12),
              ] else if (icon != null) ...[
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
                isLoading ? 'Please wait...' : text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: outlined || isLoading
                      ? (isLoading ? Colors.white70 : AppTheme.primaryGoldLight)
                      : AppTheme.textDarkNavy,
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
