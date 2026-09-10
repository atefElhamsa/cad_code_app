import 'package:cad_code_academy/features/course_workspace/presentation/cubits/workspace_tasks_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../presentation/cubits/workspace_tasks_cubit.dart';
import 'native_file_viewer_view.dart';

import '../../../widgets/empty_state_widget.dart';

class WorkspaceTasksTab extends StatelessWidget {
  const WorkspaceTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkspaceTasksCubit, WorkspaceTasksState>(
      builder: (context, state) {
        if (state is WorkspaceTasksLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
          );
        } else if (state is WorkspaceTasksLoaded) {
          if (state.tasks.isEmpty) {
            return const EmptyStateWidget(
              title: 'No tasks yet',
              subtitle: 'Check back later for new tasks in this folder.',
              icon: Icons.assignment_turned_in_outlined,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              final hasSubmitted = state.submissions.any(
                (s) => s.taskId == task.id,
              );

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.assignment_rounded,
                            color: Color(0xFFD4AF37),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            task.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: hasSubmitted
                                ? Colors.green.withOpacity(0.1)
                                : const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            hasSubmitted ? 'تم الرفع' : 'مطلوب',
                            style: TextStyle(
                              color: hasSubmitted
                                  ? Colors.green
                                  : Colors.orange.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (task.description != null &&
                        task.description!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        task.description!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NativeFileViewerView(
                                    driveUrl: task.driveUrl,
                                    fileName: task.title,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.visibility_rounded,
                              size: 20,
                            ),
                            label: const Text('عرض التاسك'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF00E5FF),
                              side: const BorderSide(
                                color: Color(0xFF00E5FF),
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: hasSubmitted
                                ? null
                                : () async {
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles();
                                    if (!context.mounted) return;
                                    if (result != null &&
                                        result.files.single.path != null) {
                                      context
                                          .read<WorkspaceTasksCubit>()
                                          .submitTask(
                                            task,
                                            result.files.single.path!,
                                          );
                                    }
                                  },
                            icon: const Icon(Icons.upload_rounded, size: 20),
                            label: Text(hasSubmitted ? 'تم الرفع' : 'رفع الحل'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4AF37),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey.shade300,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is WorkspaceTasksError) {
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
