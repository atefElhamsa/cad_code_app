import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/brand_header.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../viewmodels/edit_profile_cubit.dart';
import 'edit_profile_avatar_section.dart';
import 'edit_profile_form_section.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, authState) {
          context.read<EditProfileCubit>().syncAvatarFromAuthState(authState);

          if (authState is AuthError) {
            CustomSnackBar.showError(context, authState.message);
          } else if (authState is AuthActionSuccess) {
            CustomSnackBar.showSuccess(context, authState.message);
            if (authState.message.contains('Profile updated')) context.pop();
          }
        },
        builder: (context, authState) {
          final isAuthLoading = authState is AuthLoading;

          return Column(
            children: [
              BrandHeader(
                title: 'Edit Profile',
                showBack: true,
                onBack: isAuthLoading ? () {} : () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditProfileAvatarSection(isAuthLoading: isAuthLoading),
                      const SizedBox(height: 32),
                      EditProfileFormSection(isAuthLoading: isAuthLoading),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
