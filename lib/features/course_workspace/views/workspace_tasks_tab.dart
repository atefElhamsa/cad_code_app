import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubits/workspace_tasks_cubit.dart';
import '../presentation/cubits/workspace_tasks_states.dart';
import 'native_file_viewer_view.dart';
import '../../../widgets/empty_state_widget.dart';
import '../../../core/theme/app_theme.dart';

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
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return _ItemTile(
                title: task.title,
                icon: Icons.assignment_rounded,
                iconColor: const Color(0xFFD4AF37),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NativeFileViewerView(
                      driveUrl: task.driveUrl,
                      fileName: task.title,
                    ),
                  ),
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

class _ItemTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ItemTile({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: AppTheme.textDarkNavy,
                  fontFamily: 'Inter',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // View button
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGoldLight.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.visibility_rounded,
                  color: AppTheme.primaryGoldDark,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
