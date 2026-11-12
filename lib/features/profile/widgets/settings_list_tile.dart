import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_theme.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final Widget Function(Color) iconBuilder;
  final VoidCallback onTap;
  final bool isDestructive;
  final Color? customColor;

  const SettingsListTile({
    super.key,
    required this.title,
    required this.iconBuilder,
    required this.onTap,
    this.isDestructive = false,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        customColor ??
        (isDestructive ? const Color(0xFFE53935) : AppTheme.primaryCyan);

    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      16.5,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return SizedBox(
      height: 68,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: iconBuilder(iconColor).animate().scale(
              delay: 400.ms,
              duration: 400.ms,
              curve: Curves.easeOutBack,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? iconColor : AppTheme.textDarkNavy,
            fontWeight: FontWeight.w700,
            fontSize: titleFontSize,
            fontFamily: 'Inter',
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey.shade300,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
