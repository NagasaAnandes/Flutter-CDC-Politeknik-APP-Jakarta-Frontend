import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';
import '../widgets/settings_menu_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: AppContentLayout(
        type: LayoutType.home,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            SettingsMenuItem(
              icon: Icons.info_outline,
              title: 'Tentang Aplikasi',
              onTap: () => context.go('/app/settings/about'),
            ),
          ],
        ),
      ),
    );
  }
}
