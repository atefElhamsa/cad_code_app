import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
              title,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 200.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
        SizedBox(height: 8.h,),
        Text(
              subtitle,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 300.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
      ],
    );
  }
}
