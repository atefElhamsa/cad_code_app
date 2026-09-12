import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/task_model.dart';
import 'workspace_tasks_states.dart';

class WorkspaceTasksCubit extends Cubit<WorkspaceTasksState> {
  final int folderId;
  final _supabase = Supabase.instance.client;

  WorkspaceTasksCubit({required this.folderId})
    : super(WorkspaceTasksInitial()) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    emit(WorkspaceTasksLoading());
    try {
      final tasksResponse = await _supabase
          .from('tasks')
          .select()
          .eq('folder_id', folderId)
          .order('created_at', ascending: true);

      final tasks = (tasksResponse as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();

      emit(WorkspaceTasksLoaded(tasks: tasks));
    } catch (e) {
      emit(WorkspaceTasksError('حدث خطأ أثناء تحميل التاسكات: $e'));
    }
  }
}
