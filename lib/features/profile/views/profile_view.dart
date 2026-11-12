import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../../auth/presentation/viewmodels/auth_state.dart';

import '../../../core/responsive/responsive.dart';
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
    final showTwoPanes = context.screenWidth > 900;

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

          final emailFontSize = ResponsiveUtils.fontSize(
            context,
            16,
            minScale: 1.0,
            maxScale: 1.15,
          );

          Widget bodyContent;

          if (showTwoPanes) {
            bodyContent = IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left Pane: User info card
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileUserInfo(
                              name: name,
                              phone: phone,
                              avatarUrl: avatarUrl,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              email,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.textGray,
                                fontSize: emailFontSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ).animate().fade(delay: 300.ms),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 28),

                  // Right Pane: Menu options
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileMenuCard(
                          children: [
                            ProfileMenuItem(
                              icon: Icons.person_outline,
                              title: 'Edit Profile',
                              onTap: () => context.push('/edit-profile'),
                            ),
                            const ProfileMenuDivider(),
                            ProfileMenuItem(
                              icon: Icons.lock_outline,
                              title: 'Change Password',
                              onTap: () => context.push('/change-password'),
                            ),
                          ],
                        ).animate().fade(delay: 400.ms).slideY(begin: 0.1),

                        const SizedBox(height: 24),

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
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            bodyContent = Column(
              children: [
                ProfileUserInfo(
                  name: name,
                  phone: phone,
                  avatarUrl: avatarUrl,
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: TextStyle(
                    color: AppTheme.textGray,
                    fontSize: emailFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fade(delay: 300.ms),
                const SizedBox(height: 32),

                ProfileMenuCard(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () => context.push('/edit-profile'),
                    ),
                    const ProfileMenuDivider(),
                    ProfileMenuItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () => context.push('/change-password'),
                    ),
                  ],
                ).animate().fade(delay: 400.ms).slideY(begin: 0.1),

                const SizedBox(height: 24),

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

                const SizedBox(height: 32),
              ],
            );
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
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
