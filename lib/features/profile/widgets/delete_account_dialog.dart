import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/presentation/viewmodels/auth_cubit.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      contentPadding: EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_rounded,
              color: Colors.redAccent,
              size: 36,
            ),
          ).animate().scale(delay: 100.ms, curve: Curves.easeOutBack),
          SizedBox(height: 20.h,),
          Text(
            'Delete Account?',
            style: TextStyle(
              color: AppTheme.textDarkNavy,
              fontWeight: FontWeight.w900,
              fontSize: 22.sp,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 12.h,),
          Text(
            'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textGray,
              fontSize: 15.sp,
              height: 1.5,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 32.h,),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppTheme.textGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    context.read<AuthCubit>().deleteAccount();
                    context.go('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
