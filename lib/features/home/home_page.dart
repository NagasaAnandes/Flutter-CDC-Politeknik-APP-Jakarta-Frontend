import 'package:flutter/material.dart';

import 'widgets/home_announcement_section.dart';
import 'widgets/home_event_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_job_section.dart';

import '../../../core/layout/app_content_layout.dart';
import '../../../core/layout/app_layout_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER (FULL WIDTH) =================
            const HomeHeader(),

            // ================= CONTENT (CONSTRAINED VIA WRAPPER) =================
            AppContentLayout(
              type: LayoutType.home,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 16),
                  HomeAnnouncementSection(),

                  SizedBox(height: 32),
                  HomeJobSection(),

                  SizedBox(height: 32),
                  HomeEventSection(),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
