import '../../data/models/task_model.dart';
import '../../data/models/task_submission_model.dart';

abstract class WorkspaceTasksState {}

class WorkspaceTasksInitial extends WorkspaceTasksState {}

class WorkspaceTasksLoading extends WorkspaceTasksState {}

class WorkspaceTasksLoaded extends WorkspaceTasksState {
  final List<TaskModel> tasks;
  final List<TaskSubmissionModel> submissions;
  WorkspaceTasksLoaded({required this.tasks, required this.submissions});
}

class WorkspaceTasksError extends WorkspaceTasksState {
  final String message;
  WorkspaceTasksError(this.message);
}
