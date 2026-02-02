import 'package:flutter/material.dart';

import 'widgets/home_announcement_section.dart';
import 'widgets/home_event_section.dart';
import 'widgets/home_header.dart';
import 'widgets/home_job_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  double _horizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 900) {
      return 32; // tablet landscape
    } else if (width >= 600) {
      return 24; // tablet portrait
    } else {
      return 16; // mobile
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = _horizontalPadding(context);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER (FULL WIDTH) =================
            const HomeHeader(),

            // ================= CONTENT (CONSTRAINED) =================
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
