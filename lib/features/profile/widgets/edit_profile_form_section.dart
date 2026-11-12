import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../viewmodels/edit_profile_cubit.dart';
import '../viewmodels/edit_profile_state.dart';
import 'field_label.dart';
import 'primary_action_button.dart';
import 'profile_input_field.dart';

class EditProfileFormSection extends StatelessWidget {
  final bool isAuthLoading;

  const EditProfileFormSection({super.key, required this.isAuthLoading});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    final titleFontSize = ResponsiveUtils.fontSize(
      context,
      20,
      minScale: 1.0,
      maxScale: 1.15,
    );
    final descFontSize = ResponsiveUtils.fontSize(
      context,
      14,
      minScale: 1.0,
      maxScale: 1.15,
    );

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (prev, curr) => prev.hasChanges != curr.hasChanges,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDarkNavy,
                fontFamily: 'Inter',
              ),
            ).animate().fade(delay: 100.ms).slideY(begin: 0.1),
            const SizedBox(height: 8),
            Text(
              'Update your name and phone number so we can reach you.',
              style: TextStyle(
                fontSize: descFontSize,
                color: AppTheme.textGray,
                fontFamily: 'Inter',
              ),
            ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),
            const FieldLabel('Full Name').animate().fade(delay: 300.ms),
            const SizedBox(height: 8),
            ProfileInputField(
              controller: cubit.nameController,
              hintText: 'e.g. John Doe',
              icon: Icons.person_outline_rounded,
              enabled: !isAuthLoading,
            ).animate().fade(delay: 350.ms).slideY(begin: 0.1),
            const SizedBox(height: 24),
            const FieldLabel('Phone Number').animate().fade(delay: 400.ms),
            const SizedBox(height: 8),
            ProfileInputField(
              controller: cubit.phoneController,
              hintText: 'e.g. 01012345678',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              enabled: !isAuthLoading,
            ).animate().fade(delay: 450.ms).slideY(begin: 0.1),
            const SizedBox(height: 40),
            PrimaryActionButton(
              text: 'Save Changes',
              isLoading: isAuthLoading,
              onPressed: (isAuthLoading || !state.hasChanges)
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      if (!cubit.isNameValid) {
                        CustomSnackBar.showError(
                          context,
                          'Name cannot be empty.',
                        );
                        return;
                      }
                      cubit.saveAll();
                    },
            ).animate().fade(delay: 500.ms).slideY(begin: 0.2),
          ],
        );
      },
    );
  }
}
