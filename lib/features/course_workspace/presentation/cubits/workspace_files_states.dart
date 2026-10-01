import 'package:cad_code_academy/features/course_workspace/data/models/course_file_model.dart';

abstract class WorkspaceFilesState {}

class WorkspaceFilesInitial extends WorkspaceFilesState {}

class WorkspaceFilesLoading extends WorkspaceFilesState {}

class WorkspaceFilesLoaded extends WorkspaceFilesState {
  final List<CourseFileModel> files;
  WorkspaceFilesLoaded(this.files);
}

class WorkspaceFilesError extends WorkspaceFilesState {
  final String message;
  WorkspaceFilesError(this.message);
}
