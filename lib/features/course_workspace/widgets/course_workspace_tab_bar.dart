import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';

class CourseWorkspaceTabBar extends StatelessWidget {
  const CourseWorkspaceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabFontSize = ResponsiveUtils.fontSize(
      context,
      13,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return ResponsiveConstraint(
      tabletMaxWidth: 680,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
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
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          labelColor: const Color(0xFFB8860B),
          unselectedLabelColor: Colors.grey.shade400,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: tabFontSize,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: tabFontSize,
          ),
          tabs: const [
            Tab(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.laptop_mac_rounded, size: 20),
                  SizedBox(width: 6),
                  Text('Sessions'),
                ],
              ),
            ),
            Tab(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_rounded, size: 20),
                  SizedBox(width: 6),
                  Text('Tasks'),
                ],
              ),
            ),
            Tab(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_rounded, size: 20),
                  SizedBox(width: 6),
                  Text('Files'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
