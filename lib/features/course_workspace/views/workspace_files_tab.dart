import 'package:flutter/material.dart';

import '../../../widgets/file_tile.dart';

class WorkspaceFilesTab extends StatelessWidget {
  const WorkspaceFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FileTile(name: 'Dart_Cheatsheet.pdf', type: 'pdf', onDownload: () {}),
        FileTile(name: 'Starter_Project.zip', type: 'zip', onDownload: () {}),
        FileTile(name: 'Lecture_Notes_01.doc', type: 'doc', onDownload: () {}),
      ],
    );
  }
}
