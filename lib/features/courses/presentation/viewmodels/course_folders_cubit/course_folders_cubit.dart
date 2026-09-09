import 'package:cad_code_academy/features/courses/domain/repositories/course_folders_repository.dart';
import 'package:cad_code_academy/features/courses/domain/repositories/access_code_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_folders_state.dart';

class CourseFoldersCubit extends Cubit<CourseFoldersState> {
  final CourseFoldersRepository repository;
  final AccessCodeRepository accessCodeRepository;

  CourseFoldersCubit(this.repository, this.accessCodeRepository)
    : super(CourseFoldersInitial());

  Future<void> fetchCourseFolders(int courseId) async {
    emit(CourseFoldersLoading());
    try {
      final folders = await repository.getCourseFolders(courseId);
      final unlockedFolderIds = await accessCodeRepository.getUnlockedFolders();
      emit(CourseFoldersLoaded(folders, unlockedFolderIds: unlockedFolderIds));
    } catch (e) {
      emit(CourseFoldersError(e.toString()));
    }
  }

  void addUnlockedFolder(int folderId) {
    if (state is CourseFoldersLoaded) {
      final currentState = state as CourseFoldersLoaded;
      final newUnlockedIds = List<int>.from(currentState.unlockedFolderIds)
        ..add(folderId);
      emit(currentState.copyWith(unlockedFolderIds: newUnlockedIds));
    }
  }
}
