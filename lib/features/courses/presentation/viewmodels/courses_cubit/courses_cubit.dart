import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cad_code_academy/features/courses/domain/usecases/get_courses_usecase.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final GetCoursesUseCase getCoursesUseCase;

  CoursesCubit(this.getCoursesUseCase) : super(CoursesInitial());

  Future<void> fetchCourses() async {
    emit(CoursesLoading());
    try {
      final courses = await getCoursesUseCase();
      emit(CoursesLoaded(courses));
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }
}
