import 'package:cad_code_academy/features/courses/domain/usecases/get_enrolled_courses_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enrolled_courses_state.dart';

class EnrolledCoursesCubit extends Cubit<EnrolledCoursesState> {
  final GetEnrolledCoursesUseCase getEnrolledCoursesUseCase;

  EnrolledCoursesCubit(this.getEnrolledCoursesUseCase)
    : super(EnrolledCoursesInitial());

  Future<void> fetchEnrolledCourses() async {
    emit(EnrolledCoursesLoading());
    try {
      final courses = await getEnrolledCoursesUseCase();
      emit(EnrolledCoursesLoaded(courses));
    } catch (e) {
      emit(EnrolledCoursesError(e.toString()));
    }
  }
}
