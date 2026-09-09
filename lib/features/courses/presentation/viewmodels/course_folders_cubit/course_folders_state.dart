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
  final List<int> unlockedFolderIds;

  const CourseFoldersLoaded(this.folders, {this.unlockedFolderIds = const []});

  CourseFoldersLoaded copyWith({
    List<CourseFolderEntity>? folders,
    List<int>? unlockedFolderIds,
  }) {
    return CourseFoldersLoaded(
      folders ?? this.folders,
      unlockedFolderIds: unlockedFolderIds ?? this.unlockedFolderIds,
    );
  }

  @override
  List<Object> get props => [folders, unlockedFolderIds];
}

class CourseFoldersError extends CourseFoldersState {
  final String message;

  const CourseFoldersError(this.message);

  @override
  List<Object> get props => [message];
}
