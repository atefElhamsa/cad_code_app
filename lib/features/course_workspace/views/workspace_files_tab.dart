import 'package:cad_code_academy/features/course_workspace/presentation/cubits/workspace_files_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubits/workspace_files_cubit.dart';
import 'native_file_viewer_view.dart';

import '../../../widgets/empty_state_widget.dart';

class WorkspaceFilesTab extends StatelessWidget {
  const WorkspaceFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkspaceFilesCubit, WorkspaceFilesState>(
      builder: (context, state) {
        if (state is WorkspaceFilesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
          );
        } else if (state is WorkspaceFilesLoaded) {
          if (state.files.isEmpty) {
            return const EmptyStateWidget(
              title: 'No files yet',
              subtitle: 'Check back later for new files in this folder.',
              icon: Icons.folder_open_outlined,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.files.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final file = state.files[index];
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.picture_as_pdf,
                    color: Color(0xFFD4AF37),
                  ),
                  title: Text(
                    file.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Color(0xFFD4AF37),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NativeFileViewerView(
                            driveUrl: file.driveUrl,
                            fileName: file.title,
                          ),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NativeFileViewerView(
                          driveUrl: file.driveUrl,
                          fileName: file.title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is WorkspaceFilesError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
