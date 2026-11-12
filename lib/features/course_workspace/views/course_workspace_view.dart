import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/responsive/responsive.dart';
import 'workspace_sessions_tab.dart';
import 'workspace_tasks_tab.dart';
import 'workspace_files_tab.dart';
import '../widgets/course_workspace_app_bar.dart';
import '../widgets/course_workspace_tab_bar.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_cubit.dart';
import '../presentation/cubits/workspace_files_cubit.dart';
import '../presentation/cubits/workspace_tasks_cubit.dart';
import '../data/repositories/sessions_repository_impl.dart';
import '../data/datasources/sessions_remote_data_source.dart';

class CourseWorkspaceView extends StatelessWidget {
  final int folderId;
  final String title;
  final String topic;

  const CourseWorkspaceView({
    super.key,
    required this.folderId,
    required this.title,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SessionsCubit(
            SessionsRepositoryImpl(
              SupabaseSessionsRemoteDataSourceImpl(Supabase.instance.client),
            ),
          )..fetchSessions(folderId),
        ),
        BlocProvider(
          create: (context) => WorkspaceFilesCubit(folderId: folderId),
        ),
        BlocProvider(
          create: (context) => WorkspaceTasksCubit(folderId: folderId),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xFFF4F6F9),
          appBar: CourseWorkspaceAppBar(title: title, topic: topic),
          body: Center(
            child: ResponsiveConstraint(
              tabletMaxWidth: context.screenWidth > 900 ? 1000 : 720,
              child: Column(
                children: const [
                  SizedBox(height: 16),
                  CourseWorkspaceTabBar(),
                  SizedBox(height: 12),
                  Expanded(
                    child: TabBarView(
                      children: [
                        WorkspaceSessionsTab(),
                        WorkspaceTasksTab(),
                        WorkspaceFilesTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
