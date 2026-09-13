import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundDarkNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryGoldLight.withValues(alpha: 0.5),
            width: 1.5.w,
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
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                IconButton(
                  icon: Icon(
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
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40.w,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryGoldLight, width: 2.w,),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => AppTheme.goldGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'C',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22.sp,
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
