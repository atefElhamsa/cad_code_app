import 'package:flutter/material.dart';

import 'workspace_sessions_tab.dart';
import 'workspace_tasks_tab.dart';
import 'workspace_files_tab.dart';
import '../widgets/course_workspace_app_bar.dart';
import '../widgets/course_workspace_tab_bar.dart';

class CourseWorkspaceView extends StatelessWidget {
  final String title;
  final String topic;

  const CourseWorkspaceView({
    super.key,
    required this.title,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F9),
        appBar: CourseWorkspaceAppBar(title: title, topic: topic),
        body: Column(
          children: const [
            SizedBox(height: 16),
            CourseWorkspaceTabBar(),
            SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                children: [
                  WorkspaceSessionsTab(),
                  WorkspaceTasksTab(),
                  WorkspaceFilesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
