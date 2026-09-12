import '../../data/models/task_model.dart';

abstract class WorkspaceTasksState {}

class WorkspaceTasksInitial extends WorkspaceTasksState {}

class WorkspaceTasksLoading extends WorkspaceTasksState {}

class WorkspaceTasksLoaded extends WorkspaceTasksState {
  final List<TaskModel> tasks;
  WorkspaceTasksLoaded({required this.tasks});
}

class WorkspaceTasksError extends WorkspaceTasksState {
  final String message;
  WorkspaceTasksError(this.message);
}
