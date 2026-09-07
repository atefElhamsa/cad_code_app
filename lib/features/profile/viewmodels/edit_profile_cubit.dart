import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final AuthCubit _authCubit;
  final ImagePicker _imagePicker;

  final nameController = _TextController();
  final phoneController = _TextController();

  String _initialName = '';
  String _initialPhone = '';

  EditProfileCubit({required this._authCubit, ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker(),
      super(const EditProfileState()) {
    nameController.addListener(_onFormChanged);
    phoneController.addListener(_onFormChanged);
  }

  // ── Initialization ────────────────────────────────────────────────

  void initFromAuthState(AuthState authState) {
    if (authState is Authenticated) {
      final metadata = authState.user.userMetadata ?? {};
      _initialName = metadata['name'] ?? metadata['full_name'] ?? '';
      _initialPhone = metadata['phone'] ?? '';
      final avatarUrl = metadata['avatar_url'] ?? metadata['picture'];

      nameController.text = _initialName;
      phoneController.text = _initialPhone;

      emit(state.copyWith(avatarUrl: avatarUrl, hasChanges: false));
    }
  }

  void syncAvatarFromAuthState(AuthState authState) {
    if (authState is Authenticated) {
      final metadata = authState.user.userMetadata ?? {};
      final newUrl = metadata['avatar_url'] ?? metadata['picture'];
      // بعد الحفظ: نحدث الـ URL ونمسح الصورة المحلية
      emit(state.copyWith(avatarUrl: newUrl, clearLocalImage: true));
    }
  }

  // ── Form Logic ────────────────────────────────────────────────────

  void _onFormChanged() {
    final formChanged =
        (nameController.text.trim() != _initialName ||
            phoneController.text.trim() != _initialPhone) &&
        nameController.text.trim().isNotEmpty;

    // hasChanges = تغيير في الفورم أو وجود صورة محلية لم تُرفع بعد
    final hasChanges = formChanged || state.localImagePath != null;
    emit(state.copyWith(hasChanges: hasChanges));
  }

  bool get isNameValid => nameController.text.trim().isNotEmpty;

  // ── Image Picking (محلي فقط - بدون رفع) ──────────────────────────

  Future<void> pickImageLocally(ImageSource source) async {
    final hasPermission = await _requestPermission(source);
    if (!hasPermission) return;

    emit(state.copyWith(isPickingImage: true));

    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (picked == null) {
        emit(state.copyWith(isPickingImage: false));
        return;
      }

      // حفظ الصورة محلياً فقط كـ preview - بدون رفع
      emit(
        state.copyWith(
          isPickingImage: false,
          localImagePath: picked.path,
          hasChanges: true,
        ),
      );
    } catch (e) {
      // تجاهل أخطاء image picker (مثل رفض الصلاحية)
      emit(state.copyWith(isPickingImage: false));
    }
  }

  // ── Save All (يرفع الصورة + يحفظ البيانات عند الضغط) ─────────────

  Future<void> saveAll() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final localPath = state.localImagePath;

    if (localPath != null) {
      // رفع الصورة أولاً ثم حفظ باقي البيانات
      await _authCubit.uploadAvatarThenProfile(
        filePath: localPath,
        name: name,
        phone: phone,
      );
    } else {
      // بدون صورة جديدة - حفظ البيانات فقط
      _authCubit.updateProfile(name: name, phone: phone);
    }
  }

  // ── Permissions ───────────────────────────────────────────────────

  Future<bool> _requestPermission(ImageSource source) async {
    final permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;

    final status = await permission.request();
    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}

// TextEditingController مع alias للوضوح
typedef _TextController = TextEditingController;
