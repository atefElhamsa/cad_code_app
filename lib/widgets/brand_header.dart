import 'package:flutter/material.dart';

import '../core/responsive/responsive.dart';
import '../core/theme/app_theme.dart';

class BrandHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  const BrandHeader({
    super.key,
    this.title = 'C&C Academy',
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      22,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final displayTitle = title.fixBidi;
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(displayTitle);
    final titleDirection =
        hasArabic ? TextDirection.rtl : TextDirection.ltr;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundDarkNavy,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryGoldLight.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGoldDark.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppTheme.primaryGoldLight,
                  ),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                )
              else
                _buildLogo(),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.goldGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    displayTitle,
                    textAlign: TextAlign.center,
                    textDirection: titleDirection,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryGoldLight, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            'C',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
