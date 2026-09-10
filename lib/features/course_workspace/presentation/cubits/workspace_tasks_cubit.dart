import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/task_model.dart';
import '../../data/models/task_submission_model.dart';
import '../../../../core/services/google_drive_service.dart';
import 'workspace_tasks_states.dart';

class WorkspaceTasksCubit extends Cubit<WorkspaceTasksState> {
  final int folderId;
  final _supabase = Supabase.instance.client;
  final _driveService = GoogleDriveService();

  WorkspaceTasksCubit({required this.folderId})
    : super(WorkspaceTasksInitial()) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    emit(WorkspaceTasksLoading());
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw 'User not authenticated';

      // Fetch tasks for the folder
      final tasksResponse = await _supabase
          .from('tasks')
          .select()
          .eq('folder_id', folderId)
          .order('created_at', ascending: true);

      final tasks = (tasksResponse as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();

      // Fetch student submissions for these tasks
      final submissionsResponse = await _supabase
          .from('task_submissions')
          .select()
          .eq('student_id', user.id);

      final submissions = (submissionsResponse as List)
          .map((json) => TaskSubmissionModel.fromJson(json))
          .toList();

      emit(WorkspaceTasksLoaded(tasks: tasks, submissions: submissions));
    } catch (e) {
      emit(WorkspaceTasksError('Error fetching tasks: $e'));
    }
  }

  Future<void> submitTask(TaskModel task, String filePath) async {
    final currentState = state;

    emit(WorkspaceTasksLoading());
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw 'User not authenticated';

      // 1. Upload to Google Drive
      final studentName = user.email?.split('@').first ?? 'Student';
      final title = 'Submission_${studentName}_Task${task.id}';
      final driveUrl = await _driveService.uploadFile(File(filePath), title);

      // 2. Save to Supabase
      final newSubmission = {
        'task_id': task.id,
        'student_id': user.id,
        'file_url': driveUrl,
      };

      await _supabase.from('task_submissions').upsert(newSubmission);

      // Refresh list
      fetchTasks();
    } catch (e) {
      emit(WorkspaceTasksError('Error submitting task: $e'));
      if (currentState is WorkspaceTasksLoaded) {
        // Re-emit previous state on error (optional, or just show error and re-fetch)
        fetchTasks();
      }
    }
  }
}
