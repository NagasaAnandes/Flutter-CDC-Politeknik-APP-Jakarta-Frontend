import 'package:flutter/material.dart';

import 'widgets/home_announcement_section.dart';
import 'widgets/home_event_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_job_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeHeader(),

            SizedBox(height: 16),
            HomeAnnouncementSection(),

            SizedBox(height: 32),
            HomeJobSection(),

            SizedBox(height: 32),
            HomeEventSection(),
          ],
        ),
      ),
    );
  }
}
