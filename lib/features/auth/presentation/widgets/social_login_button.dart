import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      icon: isLoading
          ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Image.asset(
              'assets/images/google_logo.png',
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
            ),
      label: Text(
        isLoading ? 'Please wait...' : 'Continue with Google',
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, curve: Curves.easeOut);
  }
}
