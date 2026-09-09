import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/access_code_repository.dart';
import 'access_code_state.dart';

class AccessCodeCubit extends Cubit<AccessCodeState> {
  final AccessCodeRepository repository;

  AccessCodeCubit(this.repository) : super(AccessCodeInitial());

  Future<void> validateCode(int folderId, String code) async {
    if (code.isEmpty) {
      emit(const AccessCodeError('Please enter an access code'));
      return;
    }

    emit(AccessCodeLoading());
    try {
      final success = await repository.validateAndUseAccessCode(folderId, code);
      if (success) {
        emit(AccessCodeSuccess());
      } else {
        emit(const AccessCodeError('Invalid access code'));
      }
    } catch (e) {
      emit(AccessCodeError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
