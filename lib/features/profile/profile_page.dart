import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/bloc/auth_event.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

import 'widgets/profile_guest_view.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Container(
        color: theme.colorScheme.surface,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // ===== GUEST =====
            if (state is AuthGuest) {
              return AppContentLayout(
                type: LayoutType.home,
                child: const ProfileGuestView(),
              );
            }

            // ===== LOGGED IN =====
            if (state is AuthAuthenticated) {
              return AppContentLayout(
                type: LayoutType.home,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    ProfileHeader(name: state.user.displayName),
                    const SizedBox(height: 24),

                    ProfileMenuItem(
                      icon: Icons.bookmark_outline,
                      title: 'Bookmark Saya',
                      onTap: () => context.goNamed('bookmark'),
                    ),

                    ProfileMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifikasi',
                      onTap: () => context.go('/app/notification'),
                    ),

                    const Divider(height: 32),

                    ProfileMenuItem(
                      icon: Icons.timeline_outlined,
                      title: 'Tracer Study',
                      onTap: () => context.go('/app/tracer'),
                    ),

                    const Divider(height: 32),

                    ProfileMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Pengaturan',
                      onTap: () => context.go('/app/settings'),
                    ),

                    const Divider(height: 32),

                    ProfileMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      textColor: Colors.red,
                      onTap: () {
                        context.read<AuthBloc>().add(
                          const AuthLogoutRequested(),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
