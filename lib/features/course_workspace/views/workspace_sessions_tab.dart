import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/session_tile.dart';
import '../../../widgets/empty_state_widget.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_cubit.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_state.dart';

class WorkspaceSessionsTab extends StatelessWidget {
  const WorkspaceSessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionsCubit, SessionsState>(
      builder: (context, state) {
        if (state is SessionsLoading) {
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: Colors.white54);
            },
          );
        } else if (state is SessionsError) {
          return Center(
            child: Text(
              'Failed to load sessions: ${state.message}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (state is SessionsLoaded) {
          if (state.sessions.isEmpty) {
            return const EmptyStateWidget(
              title: 'No sessions yet',
              subtitle: 'Check back later for new sessions in this folder.',
              icon: Icons.video_library_outlined,
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.sessions.length,
            itemBuilder: (context, index) {
              final session = state.sessions[index];
              return SessionTile(
                title: session.title,
                duration: session.duration ?? '',
                onPlay: () {
                  context.push(
                    '/video-player',
                    extra: {
                      'driveUrl': session.driveUrl,
                      'title': session.title,
                    },
                  );
                },
              );
            },
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
