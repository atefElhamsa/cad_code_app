import 'package:flutter/material.dart';

import '../../../widgets/task_tile.dart';

class WorkspaceTasksTab extends StatelessWidget {
  const WorkspaceTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TaskTile(
          title: 'Task 1: Basic Calculator',
          status: 'Reviewed',
          onUpload: () {},
        ),
        TaskTile(
          title: 'Task 2: CLI To-Do App',
          status: 'Submitted',
          onUpload: () {},
        ),
        TaskTile(
          title: 'Task 3: Object Oriented Design',
          status: 'Pending',
          onUpload: () {
            // TODO: Trigger file upload
          },
        ),
      ],
    );
  }
}
