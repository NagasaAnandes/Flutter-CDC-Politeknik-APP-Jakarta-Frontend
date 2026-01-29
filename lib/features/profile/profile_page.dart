import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/bloc/auth_event.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/auth/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

import 'widgets/profile_guest_view.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // ===== GUEST =====
          if (state is AuthGuest) {
            return const ProfileGuestView();
          }

          // ===== LOGGED IN =====
          if (state is AuthAuthenticated) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfileHeader(name: state.user.displayName),
                const SizedBox(height: 24),

                ProfileMenuItem(
                  icon: Icons.bookmark_outline,
                  title: 'Bookmark Saya',
                  onTap: () {
                    context.goNamed('bookmark');
                  },
                ),

                ProfileMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifikasi',
                  onTap: () {
                    context.go('/app/notification');
                  },
                ),

                const Divider(height: 32),

                ProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  textColor: Colors.red,
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthLogoutRequested());
                  },
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
