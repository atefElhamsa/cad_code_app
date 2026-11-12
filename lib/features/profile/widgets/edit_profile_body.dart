import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';
import '../../../core/responsive/responsive.dart';
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
    final showTwoPanes = context.screenWidth > 900;

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

          Widget bodyContent;

          if (showTwoPanes) {
            bodyContent = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left pane: Avatar
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: EditProfileAvatarSection(
                        isAuthLoading: isAuthLoading,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 28),

                // Right pane: Form fields and Save button
                Expanded(
                  flex: 3,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: EditProfileFormSection(isAuthLoading: isAuthLoading),
                  ),
                ),
              ],
            );
          } else {
            bodyContent = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditProfileAvatarSection(
                  isAuthLoading: isAuthLoading,
                ),
                const SizedBox(height: 32),
                EditProfileFormSection(isAuthLoading: isAuthLoading),
              ],
            );
          }

          return Column(
            children: [
              BrandHeader(
                title: 'Edit Profile',
                showBack: true,
                onBack: isAuthLoading ? () {} : () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: ResponsiveConstraint(
                    tabletMaxWidth: showTwoPanes ? 1000 : 560,
                    child: bodyContent,
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
