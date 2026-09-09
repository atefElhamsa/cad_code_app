import 'package:cad_code_academy/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:cad_code_academy/features/auth/data/datasources/supabase_auth_remote_data_source_impl.dart';
import 'package:cad_code_academy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cad_code_academy/features/auth/domain/repositories/auth_repository.dart';
import 'package:cad_code_academy/features/auth/domain/usecases/auth_usecases.dart';
import 'package:cad_code_academy/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:cad_code_academy/features/courses/data/datasources/courses_remote_data_source.dart';
import 'package:cad_code_academy/features/courses/data/repositories/courses_repository_impl.dart';
import 'package:cad_code_academy/features/courses/domain/repositories/courses_repository.dart';
import 'package:cad_code_academy/features/courses/domain/usecases/get_courses_usecase.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/domain/usecases/get_enrolled_courses_usecase.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => SupabaseAuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignInWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserPasswordUseCase(sl()));
  sl.registerLazySingleton(() => UploadAvatarUseCase(sl()));

  sl.registerLazySingleton(
    () => AuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );

  // Courses
  sl.registerLazySingleton<CoursesRemoteDataSource>(
    () => SupabaseCoursesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CoursesRepository>(
    () => CoursesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetCoursesUseCase(sl()));
  sl.registerLazySingleton(() => CoursesCubit(sl()));

  sl.registerLazySingleton(() => GetEnrolledCoursesUseCase(sl()));
  sl.registerLazySingleton(() => EnrolledCoursesCubit(sl()));

  sl.registerLazySingleton(() => Supabase.instance.client);
}
