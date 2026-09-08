import 'package:cad_code_academy/features/courses/domain/entities/course_folder_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CourseFoldersState extends Equatable {
  const CourseFoldersState();

  @override
  List<Object> get props => [];
}

class CourseFoldersInitial extends CourseFoldersState {}

class CourseFoldersLoading extends CourseFoldersState {}

class CourseFoldersLoaded extends CourseFoldersState {
  final List<CourseFolderEntity> folders;

  const CourseFoldersLoaded(this.folders);

  @override
  List<Object> get props => [folders];
}

class CourseFoldersError extends CourseFoldersState {
  final String message;

  const CourseFoldersError(this.message);

  @override
  List<Object> get props => [message];
}
