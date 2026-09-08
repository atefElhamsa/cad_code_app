import 'package:cad_code_academy/features/courses/domain/repositories/course_folders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_folders_state.dart';

class CourseFoldersCubit extends Cubit<CourseFoldersState> {
  final CourseFoldersRepository repository;

  CourseFoldersCubit(this.repository) : super(CourseFoldersInitial());

  Future<void> fetchCourseFolders(int courseId) async {
    emit(CourseFoldersLoading());
    try {
      final folders = await repository.getCourseFolders(courseId);
      emit(CourseFoldersLoaded(folders));
    } catch (e) {
      emit(CourseFoldersError(e.toString()));
    }
  }
}
