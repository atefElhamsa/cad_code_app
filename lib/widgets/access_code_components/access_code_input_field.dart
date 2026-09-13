import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AccessCodeInputField extends StatelessWidget {
  final TextEditingController controller;

  const AccessCodeInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 18.sp,
        color: AppTheme.textDarkNavy,
        letterSpacing: 2,
      ),
      decoration: InputDecoration(
        hintText: 'Access Code',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          letterSpacing: 0,
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: AppTheme.backgroundDarkNavy.withValues(alpha: 0.03),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5.w,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppTheme.primaryCyan, width: 2.w,),
        ),
      ),
    );
  }
}
