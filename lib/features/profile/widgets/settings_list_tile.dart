import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
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
          fontSize: 16.sp,
          fontFamily: 'Inter',
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey.shade300,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
