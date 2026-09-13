import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';

import '../../../widgets/brand_header.dart';
import '../../../widgets/profile_user_info.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/profile_menu_card.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_menu_divider.dart';
import '../widgets/delete_account_dialog.dart';

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
                  padding: EdgeInsets.only(
                    top: 24,
                    bottom: 32,
                    left: 20,
                    right: 20,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 700),
                      child: Column(
                        children: [
                          ProfileUserInfo(
                            name: name,
                            phone: phone,
                            avatarUrl: avatarUrl,
                          ),
                          SizedBox(height: 12.h,),
                          Text(
                            email,
                            style: TextStyle(
                              color: AppTheme.textGray,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ).animate().fade(delay: 300.ms),
                          SizedBox(height: 40.h,),

                          // Profile Menu Options
                          ProfileMenuCard(
                            children: [
                              ProfileMenuItem(
                                icon: Icons.person_outline,
                                title: 'Edit Profile',
                                onTap: () {
                                  context.push('/edit-profile');
                                },
                              ),
                              const ProfileMenuDivider(),
                              ProfileMenuItem(
                                icon: Icons.lock_outline,
                                title: 'Change Password',
                                onTap: () {
                                  context.push('/change-password');
                                },
                              ),
                            ],
                          ).animate().fade(delay: 400.ms).slideY(begin: 0.1),

                          SizedBox(height: 24.h,),

                          ProfileMenuCard(
                            children: [
                              ProfileMenuItem(
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
                              const ProfileMenuDivider(),
                              ProfileMenuItem(
                                icon: Icons.delete_outline_rounded,
                                title: 'Delete Account',
                                titleColor: Colors.redAccent,
                                iconColor: Colors.redAccent,
                                showTrailing: false,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => const DeleteAccountDialog(),
                                  );
                                },
                              ),
                            ],
                          ).animate().fade(delay: 500.ms).slideY(begin: 0.1),

                          SizedBox(height: 32.h,),
                        ],
                      ),
                    ),
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
