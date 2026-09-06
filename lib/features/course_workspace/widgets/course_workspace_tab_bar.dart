import 'package:flutter/material.dart';

class CourseWorkspaceTabBar extends StatelessWidget {
  const CourseWorkspaceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        indicatorPadding: const EdgeInsets.all(6),
        indicator: BoxDecoration(
          color: const Color(0xFFFDF7E6),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.5), width: 1.5),
        ),
        labelColor: const Color(0xFFB8860B),
        unselectedLabelColor: Colors.grey.shade400,
        labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        padding: EdgeInsets.zero,
        tabs: [
          Tab(height: 52, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.laptop_mac_rounded, size: 20), SizedBox(width: 6), Text('Sessions')])),
          Tab(height: 52, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.assignment_rounded, size: 20), SizedBox(width: 6), Text('Tasks')])),
          Tab(height: 52, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.folder_rounded, size: 20), SizedBox(width: 6), Text('Files')])),
        ],
      ),
    );
  }
}
