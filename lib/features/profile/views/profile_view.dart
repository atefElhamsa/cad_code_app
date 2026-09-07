import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/profile_user_info.dart';
import '../../../core/theme/app_theme.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          String name = 'Student';
          String phone = 'No phone provided';
          String email = 'No email provided';
          String? avatarUrl;

          if (authState is Authenticated) {
            final metadata = authState.user.userMetadata ?? {};
            name =
                metadata['name'] ??
                metadata['full_name'] ??
                authState.user.email?.split('@').first ??
                'Student';
            phone = metadata['phone'] ?? 'No phone provided';
            email = authState.user.email ?? 'No email provided';
            avatarUrl = metadata['avatar_url'] ?? metadata['picture'];
          }

          return Column(
            children: [
              BrandHeader(
                title: 'Profile',
                showBack: true,
                onBack: () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 32,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      ProfileUserInfo(
                        name: name,
                        phone: phone,
                        avatarUrl: avatarUrl,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        email,
                        style: const TextStyle(
                          color: AppTheme.textGray,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ).animate().fade(delay: 300.ms),
                      const SizedBox(height: 40),

                      // Profile Menu Options
                      _buildMenuCard([
                        _buildMenuItem(
                          icon: Icons.person_outline,
                          title: 'Edit Profile',
                          onTap: () {
                            context.push('/edit-profile');
                          },
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.lock_outline,
                          title: 'Change Password',
                          onTap: () {
                            context.push('/change-password');
                          },
                        ),
                      ]).animate().fade(delay: 400.ms).slideY(begin: 0.1),

                      const SizedBox(height: 24),

                      _buildMenuCard([
                        _buildMenuItem(
                          icon: Icons.logout_rounded,
                          title: 'Sign Out',
                          titleColor: Colors.redAccent,
                          iconColor: Colors.redAccent,
                          showTrailing: false,
                          onTap: () {
                            context.read<AuthCubit>().signOut();
                            context.go('/login');
                          },
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.delete_outline_rounded,
                          title: 'Delete Account',
                          titleColor: Colors.redAccent,
                          iconColor: Colors.redAccent,
                          showTrailing: false,
                          onTap: () {
                            _showDeleteAccountDialog(context);
                          },
                        ),
                      ]).animate().fade(delay: 500.ms).slideY(begin: 0.1),

                      const SizedBox(height: 32),
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

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppTheme.primaryCyan,
    Color titleColor = AppTheme.textDarkNavy,
    bool showTrailing = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
      ),
      trailing: showTrailing
          ? const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppTheme.textGray,
            )
          : null,
      onTap: onTap,
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.redAccent,
                  size: 36,
                ),
              ).animate().scale(delay: 100.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 20),
              const Text(
                'Delete Account?',
                style: TextStyle(
                  color: AppTheme.textDarkNavy,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textGray,
                  fontSize: 15,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppTheme.textGray,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                        context.read<AuthCubit>().deleteAccount();
                        context.go('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppTheme.backgroundLight,
      indent: 60,
    );
  }
}
