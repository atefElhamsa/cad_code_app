import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CourseWorkspaceTabBar extends StatelessWidget {
  const CourseWorkspaceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: const Color(0xFFFDF7E6),
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
            width: 1.5.w,
          ),
        ),
        labelColor: const Color(0xFFB8860B),
        unselectedLabelColor: Colors.grey.shade400,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 13.sp,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13.sp,
        ),
        // padding: EdgeInsets.zero,
        tabs: [
          Tab(
            height: 52.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.laptop_mac_rounded, size: 20),
                SizedBox(width: 6.w,),
                Text('Sessions'),
              ],
            ),
          ),
          Tab(
            height: 52.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment_rounded, size: 20),
                SizedBox(width: 6.w,),
                Text('Tasks'),
              ],
            ),
          ),
          Tab(
            height: 52.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_rounded, size: 20),
                SizedBox(width: 6.w,),
                Text('Files'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
