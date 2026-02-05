import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: AppContentLayout(
        type: LayoutType.home,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'CDC Politeknik APP Jakarta',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Versi 1.0.0', style: theme.textTheme.bodySmall),
            const SizedBox(height: 24),
            Text(
              'Aplikasi Career Development Center (CDC) '
              'digunakan untuk membantu mahasiswa dan alumni '
              'dalam mengakses informasi lowongan pekerjaan, '
              'event, pengumuman, serta layanan tracer study.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text('Dikembangkan oleh', style: theme.textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(
              'Nagasa Anandes Putra Ramadhan',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text('Politeknik App Jakarta', style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
