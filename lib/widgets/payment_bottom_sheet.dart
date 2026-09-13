import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class PaymentBottomSheet extends StatelessWidget {
  final String methodName;
  final IconData icon;
  final Color iconColor;

  const PaymentBottomSheet({
    super.key,
    required this.methodName,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.textDarkNavy,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 64),
          SizedBox(height: 16.h,),
          Text(
            methodName,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.backgroundLight,
            ),
          ),
          SizedBox(height: 8.h,),
          Text(
            '01012345678', // Mock data
            style: TextStyle(
              fontSize: 18.sp,
              color: AppTheme.backgroundLight.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 32.h,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.backgroundLight,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Confirm Payment',
                style: TextStyle(color: AppTheme.textDarkNavy, fontSize: 16.sp,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
