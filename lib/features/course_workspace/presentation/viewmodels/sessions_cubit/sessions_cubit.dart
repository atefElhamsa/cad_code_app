import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/sessions_repository.dart';
import 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  final SessionsRepository repository;

  SessionsCubit(this.repository) : super(SessionsInitial());

  Future<void> fetchSessions(int folderId) async {
    emit(SessionsLoading());
    try {
      final sessions = await repository.getSessions(folderId);
      emit(SessionsLoaded(sessions));
    } catch (e) {
      emit(SessionsError(e.toString()));
    }
  }
}
