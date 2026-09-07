import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';
import '../viewmodels/edit_profile_cubit.dart';
import '../viewmodels/edit_profile_state.dart';
import 'edit_profile_avatar_circle.dart';
import 'edit_profile_camera_badge.dart';
import 'edit_profile_image_source_sheet.dart';

class EditProfileAvatarSection extends StatelessWidget {
  final bool isAuthLoading;

  const EditProfileAvatarSection({super.key, required this.isAuthLoading});

  Future<void> _onAvatarTap(BuildContext context) async {
    final source = await _showImageSourceSheet(context);
    if (source == null || !context.mounted) return;
    context.read<EditProfileCubit>().pickImageLocally(source);
  }

  Future<ImageSource?> _showImageSourceSheet(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const EditProfileImageSourceSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (prev, curr) =>
          prev.avatarUrl != curr.avatarUrl ||
          prev.localImagePath != curr.localImagePath ||
          prev.isPickingImage != curr.isPickingImage,
      builder: (context, state) {
        final isLoading = isAuthLoading || state.isPickingImage;

        return Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: isLoading ? null : () => _onAvatarTap(context),
                child: Stack(
                  children: [
                    EditProfileAvatarCircle(
                      avatarUrl: state.avatarUrl,
                      localImagePath: state.localImagePath,
                      isLoading: isLoading,
                    ),
                    const EditProfileCameraBadge(),
                  ],
                ),
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Tap to change photo',
                style: TextStyle(
                  color: AppTheme.primaryCyan.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate().fade(delay: 200.ms),
          ],
        );
      },
    );
  }
}
