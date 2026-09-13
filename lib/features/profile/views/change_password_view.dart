import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/brand_header.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../widgets/password_input_field.dart';
import '../widgets/field_label.dart';
import '../widgets/primary_action_button.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController()..addListener(_validateFields);
    _confirmPasswordController = TextEditingController()
      ..addListener(_validateFields);
  }

  void _validateFields() {
    final isValid =
        _passwordController.text.length >= 6 &&
        _passwordController.text == _confirmPasswordController.text;
    if (_isValid != isValid) setState(() => _isValid = isValid);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    FocusScope.of(context).unfocus();
    final password = _passwordController.text;
    if (password.isEmpty || password.length < 6) {
      CustomSnackBar.showError(
        context,
        'Password must be at least 6 characters long.',
      );
      return;
    }
    if (password != _confirmPasswordController.text) {
      CustomSnackBar.showError(context, 'Passwords do not match.');
      return;
    }
    context.read<AuthCubit>().updatePassword(password);
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
                title: 'Change Password',
                showBack: true,
                onBack: isLoading ? () {} : () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textDarkNavy,
                          fontFamily: 'Inter',
                        ),
                      ).animate().fade(delay: 100.ms).slideY(begin: 0.1),
                      SizedBox(height: 8.h,),
                      Text(
                        'Create a new strong password for your account. Please remember it!',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textGray,
                          fontFamily: 'Inter',
                        ),
                      ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
                      SizedBox(height: 32.h,),
                      const FieldLabel('New Password')
                          .animate()
                          .fade(delay: 300.ms),
                      SizedBox(height: 8.h,),
                      PasswordInputField(
                        controller: _passwordController,
                        hintText: 'Enter new password',
                        obscureText: _obscurePassword,
                        onToggleVisibility: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        enabled: !isLoading,
                      ).animate().fade(delay: 350.ms).slideY(begin: 0.1),
                      SizedBox(height: 24.h,),
                      const FieldLabel('Confirm Password')
                          .animate()
                          .fade(delay: 400.ms),
                      SizedBox(height: 8.h,),
                      PasswordInputField(
                        controller: _confirmPasswordController,
                        hintText: 'Re-enter new password',
                        obscureText: _obscureConfirmPassword,
                        onToggleVisibility: () => setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        ),
                        enabled: !isLoading,
                      ).animate().fade(delay: 450.ms).slideY(begin: 0.1),
                      SizedBox(height: 48.h,),
                      PrimaryActionButton(
                        text: 'Update Password',
                        isLoading: isLoading,
                        onPressed: (isLoading || !_isValid)
                            ? null
                            : _updatePassword,
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
