import 'package:cad_code_academy/features/courses/domain/entities/course_entity.dart';

abstract class EnrolledCoursesState {}

class EnrolledCoursesInitial extends EnrolledCoursesState {}

class EnrolledCoursesLoading extends EnrolledCoursesState {}

class EnrolledCoursesLoaded extends EnrolledCoursesState {
  final List<CourseEntity> courses;
  EnrolledCoursesLoaded(this.courses);
}

class EnrolledCoursesError extends EnrolledCoursesState {
  final String message;
  EnrolledCoursesError(this.message);
}
