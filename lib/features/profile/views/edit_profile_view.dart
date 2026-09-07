import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/brand_header.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../widgets/profile_input_field.dart';
import '../widgets/field_label.dart';
import '../widgets/primary_action_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String _initialName = '';
  String _initialPhone = '';
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();

    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      final metadata = authState.user.userMetadata ?? {};
      _initialName = metadata['name'] ?? metadata['full_name'] ?? '';
      _initialPhone = metadata['phone'] ?? '';
      _nameController.text = _initialName;
      _phoneController.text = _initialPhone;
    }

    _nameController.addListener(_checkChanges);
    _phoneController.addListener(_checkChanges);
  }

  void _checkChanges() {
    final hasChanges =
        (_nameController.text.trim() != _initialName ||
            _phoneController.text.trim() != _initialPhone) &&
        _nameController.text.trim().isNotEmpty;
    if (_hasChanges != hasChanges) setState(() => _hasChanges = hasChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    FocusScope.of(context).unfocus();
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      CustomSnackBar.showError(context, 'Name cannot be empty.');
      return;
    }
    context.read<AuthCubit>().updateProfile(
      name: name,
      phone: _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackBar.showError(context, state.message);
          } else if (state is AuthActionSuccess) {
            CustomSnackBar.showSuccess(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Column(
            children: [
              BrandHeader(
                title: 'Edit Profile',
                showBack: true,
                onBack: isLoading ? () {} : () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textDarkNavy,
                          fontFamily: 'Inter',
                        ),
                      ).animate().fade(delay: 100.ms).slideY(begin: 0.1),
                      const SizedBox(height: 8),
                      const Text(
                        'Update your name and phone number so we can reach you.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textGray,
                          fontFamily: 'Inter',
                        ),
                      ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
                      const SizedBox(height: 32),
                      const FieldLabel('Full Name')
                          .animate()
                          .fade(delay: 300.ms),
                      const SizedBox(height: 8),
                      ProfileInputField(
                        controller: _nameController,
                        hintText: 'e.g. John Doe',
                        icon: Icons.person_outline_rounded,
                        enabled: !isLoading,
                      ).animate().fade(delay: 350.ms).slideY(begin: 0.1),
                      const SizedBox(height: 24),
                      const FieldLabel('Phone Number')
                          .animate()
                          .fade(delay: 400.ms),
                      const SizedBox(height: 8),
                      ProfileInputField(
                        controller: _phoneController,
                        hintText: 'e.g. 01012345678',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        enabled: !isLoading,
                      ).animate().fade(delay: 450.ms).slideY(begin: 0.1),
                      const SizedBox(height: 48),
                      PrimaryActionButton(
                        text: 'Save Changes',
                        isLoading: isLoading,
                        onPressed: (isLoading || !_hasChanges)
                            ? null
                            : _saveProfile,
                      ).animate().fade(delay: 500.ms).slideY(begin: 0.2),
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
