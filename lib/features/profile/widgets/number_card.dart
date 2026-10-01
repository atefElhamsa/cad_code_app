import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';

class NumberCard extends StatelessWidget {
  final String number;
  final VoidCallback onCopy;
  final Widget icon;

  const NumberCard({
    super.key,
    required this.number,
    required this.onCopy,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 50.w, height: 50.h, child: icon),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  number,
                  style: TextStyle(
                    color: AppTheme.textDarkNavy,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: onCopy,
            icon: const Icon(Icons.copy_rounded, size: 18),
            label: const Text('Copy'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primaryGoldDark,
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
