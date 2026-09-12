import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/session_tile.dart';
import '../../../widgets/empty_state_widget.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_cubit.dart';
import '../presentation/viewmodels/sessions_cubit/sessions_state.dart';
import 'session_video_player_view.dart';

class WorkspaceSessionsTab extends StatelessWidget {
  const WorkspaceSessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionsCubit, SessionsState>(
      builder: (context, state) {
        if (state is SessionsLoading) {
          return const Center(child: CircularProgressIndicator());
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

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.sessions.length,
            itemBuilder: (context, index) {
              final session = state.sessions[index];
              return SessionTile(
                title: session.title,
                duration: session.duration ?? '',
                onPlay: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SessionVideoPlayerView(
                        driveUrl: session.driveUrl,
                        title: session.title,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
