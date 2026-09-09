import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cad_code_academy/features/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/courses_cubit/courses_cubit.dart';
import 'package:cad_code_academy/features/courses/presentation/viewmodels/enrolled_courses_cubit/enrolled_courses_cubit.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tjzhjlauvceycwmnumhf.supabase.co',
    // ignore: deprecated_member_use
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqemhqbGF1dmNleWN3bW51bWhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODg3MTk0OTcsImV4cCI6MjEwNDI5NTQ5N30.1qfeyiWpHeMY9_fUiao7C-CLb3p-nKHiJHXCd7mtsVc',
  );

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(
          create: (context) => di.sl<CoursesCubit>()..fetchCourses(),
        ),
        BlocProvider(
          create: (context) => di.sl<EnrolledCoursesCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'C&C Academy',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
