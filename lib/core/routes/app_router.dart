import 'package:cad_code_academy/features/courses/views/course_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/main/views/main_layout_view.dart';
import '../../features/courses/views/home_view.dart';
import '../../features/courses/views/enrolled_courses_view.dart';
import '../../features/profile/views/settings_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/profile/views/edit_profile_view.dart';
import '../../features/profile/views/change_password_view.dart';
import '../../features/profile/views/downloads_view.dart';
import '../../features/profile/views/payment_view.dart';
import '../../features/course_workspace/views/course_workspace_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorMyCoursesKey = GlobalKey<NavigatorState>(
  debugLabel: 'myCourses',
);
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'settings',
);

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashView()),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupView()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(path: '/', builder: (context, state) => const HomeView()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMyCoursesKey,
            routes: [
              GoRoute(
                path: '/my-courses',
                builder: (context, state) => const EnrolledCoursesView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsView(),
              ),
            ],
          ),
        ],
      ),

      // Other routes outside the shell
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
        path: '/downloads',
        builder: (context, state) => const DownloadsView(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentView(),
      ),
      GoRoute(
        path: '/workspace',
        builder: (context, state) =>
            const CourseWorkspaceView(title: 'Dart', topic: 'Dart'),
      ),
      GoRoute(
        path: '/course-detail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CourseDetailView(
            courseId: extra?['id'] as int?,
            title: extra?['title'] as String? ?? 'Scratch courses',
            imageUrl: extra?['imageUrl'] as String? ?? 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=400&q=80',
          );
        },
      ),
    ],
  );
}
