import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image image;
  final Color accentColor;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.accentColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: BoxDecoration(
            color: isSelected ? accentColor : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected ? accentColor : Colors.grey.shade200,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: (isSelected ? accentColor : Colors.black)
                    .withValues(alpha: isSelected ? 0.22 : 0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52.w,
                height: 52.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.18)
                      : accentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: image
              ),
              SizedBox(width: 12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textDarkNavy,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
