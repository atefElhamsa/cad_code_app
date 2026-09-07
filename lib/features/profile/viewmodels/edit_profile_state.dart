import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  final bool hasChanges;
  final String? avatarUrl;
  final bool isPickingImage;

  /// مسار الصورة المختارة محلياً (preview قبل الحفظ)
  final String? localImagePath;

  const EditProfileState({
    this.hasChanges = false,
    this.avatarUrl,
    this.isPickingImage = false,
    this.localImagePath,
  });

  EditProfileState copyWith({
    bool? hasChanges,
    String? avatarUrl,
    bool? isPickingImage,
    String? localImagePath,
    bool clearLocalImage = false,
  }) {
    return EditProfileState(
      hasChanges: hasChanges ?? this.hasChanges,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPickingImage: isPickingImage ?? this.isPickingImage,
      localImagePath: clearLocalImage
          ? null
          : localImagePath ?? this.localImagePath,
    );
  }

  @override
  List<Object?> get props => [
    hasChanges,
    avatarUrl,
    isPickingImage,
    localImagePath,
  ];
}
