import 'package:flutter/material.dart';

import '../../../widgets/session_tile.dart';

class WorkspaceSessionsTab extends StatelessWidget {
  const WorkspaceSessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SessionTile(
          title: '01 - Introduction to Dart',
          duration: '45 mins',
          onPlay: () {},
        ),
        SessionTile(
          title: '02 - Variables and Data Types',
          duration: '1 hr 10 mins',
          onPlay: () {},
        ),
        SessionTile(
          title: '03 - Control Flow',
          duration: '50 mins',
          onPlay: () {},
        ),
      ],
    );
  }
}
