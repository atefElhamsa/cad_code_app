import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/course_file_model.dart';
import 'workspace_files_states.dart';

class WorkspaceFilesCubit extends Cubit<WorkspaceFilesState> {
  final int folderId;
  final _supabase = Supabase.instance.client;

  WorkspaceFilesCubit({required this.folderId})
    : super(WorkspaceFilesInitial()) {
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    emit(WorkspaceFilesLoading());
    try {
      final response = await _supabase
          .from('course_files')
          .select()
          .eq('folder_id', folderId)
          .order('created_at', ascending: true);

      final files = (response as List)
          .map((json) => CourseFileModel.fromJson(json))
          .toList();
      emit(WorkspaceFilesLoaded(files));
    } catch (e) {
      emit(WorkspaceFilesError('Error fetching files: $e'));
    }
  }
}
