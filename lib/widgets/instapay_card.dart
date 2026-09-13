import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_theme.dart';

class InstapayCard extends StatelessWidget {
  final String instapayNumber;

  const InstapayCard({super.key, required this.instapayNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5A2C82).withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Image(
            image: const AssetImage('assets/images/InstaPay_Logo.png'),
            width: 200.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 48.h,),
          Text(
            'Transfer Amount To',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 16.h,),
          _buildNumberBadge(context),
        ],
      ),
    );
  }

  Widget _buildNumberBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF5A2C82).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF5A2C82).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            instapayNumber,
            style: TextStyle(
              color: Color(0xFF5A2C82),
              fontSize: 26.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontFamily: 'Inter',
            ),
          ),
          IconButton(
            onPressed: () => _copyNumber(context),
            icon: Icon(
              Icons.copy_rounded,
              color: Color(0xFF5A2C82),
              size: 24,
            ),
            tooltip: 'Copy Number',
          ),
        ],
      ),
    );
  }

  void _copyNumber(BuildContext context) {
    Clipboard.setData(ClipboardData(text: instapayNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Number copied!',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryCyan,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
