import 'package:cad_code_academy/features/course_workspace/presentation/cubits/workspace_files_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubits/workspace_files_cubit.dart';
import 'native_file_viewer_view.dart';
import '../../../widgets/empty_state_widget.dart';
import '../../../core/theme/app_theme.dart';

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
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.files.length,
            itemBuilder: (context, index) {
              final file = state.files[index];
              return _FileTileItem(
                title: file.title,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NativeFileViewerView(
                      driveUrl: file.driveUrl,
                      fileName: file.title,
                    ),
                  ),
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

class _FileTileItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FileTileItem({required this.title, required this.onTap});

  IconData _getIcon() {
    final lower = title.toLowerCase();
    if (lower.endsWith('.pdf')) return Icons.picture_as_pdf_rounded;
    if (lower.endsWith('.zip') || lower.endsWith('.rar')) {
      return Icons.folder_zip_rounded;
    }
    if (lower.endsWith('.doc') || lower.endsWith('.docx')) {
      return Icons.description_rounded;
    }
    return Icons.insert_drive_file_rounded;
  }

  Color _getIconColor() {
    final lower = title.toLowerCase();
    if (lower.endsWith('.pdf')) return const Color(0xFFE53935);
    if (lower.endsWith('.zip') || lower.endsWith('.rar')) {
      return const Color(0xFFD4AF37);
    }
    if (lower.endsWith('.doc') || lower.endsWith('.docx')) {
      return const Color(0xFF1E88E5);
    }
    return AppTheme.primaryCyan;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getIconColor();
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
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(_getIcon(), color: color, size: 28),
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
