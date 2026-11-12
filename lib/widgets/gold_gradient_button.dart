import 'package:flutter/material.dart';

import '../core/responsive/responsive.dart';
import '../core/theme/app_theme.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool isLoading;
  final double? height;

  const PrimaryGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.outlined = false,
    this.isLoading = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? (context.isTablet ? 56.0 : 52.0);
    final fontSize = ResponsiveUtils.fontSize(
      context,
      17,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return SizedBox(
      height: effectiveHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppTheme.primaryGoldLight.withValues(alpha: 0.3),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: outlined || isLoading ? null : AppTheme.goldGradient,
              color: outlined || isLoading
                  ? (isLoading ? Colors.grey.shade800 : Colors.transparent)
                  : null,
              borderRadius: BorderRadius.circular(16),
              border: outlined && !isLoading
                  ? Border.all(color: AppTheme.primaryGoldLight, width: 1.8)
                  : null,
              boxShadow: outlined || isLoading
                  ? []
                  : [
                      BoxShadow(
                        color: AppTheme.primaryGoldDark.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (isLoading) ...[
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
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
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                ],
                Text(
                  isLoading ? 'Please wait...' : text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    color: outlined || isLoading
                        ? (isLoading ? Colors.white70 : AppTheme.primaryGoldLight)
                        : AppTheme.textDarkNavy,
                    letterSpacing: 1.0,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
