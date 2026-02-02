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
      bottom: false,
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _horizontalPadding(context),
              ),
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

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

double _horizontalPadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width >= 600) {
    return 32; // tablet portrait
  } else {
    return 16; // mobile
  }
}
