import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/responsive/responsive.dart';
import '../../../widgets/session_tile.dart';
import '../../../widgets/empty_state_widget.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_cubit.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_state.dart';

class WorkspaceSessionsTab extends StatelessWidget {
  const WorkspaceSessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideLandscape = context.screenWidth > 900;

    return BlocBuilder<SessionsCubit, SessionsState>(
      builder: (context, state) {
        if (state is SessionsLoading) {
          return ResponsiveConstraint(
            tabletMaxWidth: isWideLandscape ? 960 : 720,
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 1200.ms, color: Colors.white54);
              },
            ),
          );
        } else if (state is SessionsError) {
          return Center(
            child: Text(
              'Failed to load sessions: ${state.message}',
              style: const TextStyle(color: Colors.red),
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

          if (isWideLandscape) {
            return ResponsiveConstraint(
              tabletMaxWidth: 960,
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 96,
                ),
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
              ),
            );
          }

          return ResponsiveConstraint(
            tabletMaxWidth: 720,
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
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
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
