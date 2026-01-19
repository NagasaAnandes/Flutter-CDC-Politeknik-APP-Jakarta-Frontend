import 'package:flutter/material.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/home/widgets/home_announcement_section.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/home/widgets/home_event_section.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/home/widgets/home_header.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/home/widgets/home_highlight_banner.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/home/widgets/home_job_section.dart';
import 'package:flutter_cdc_poltek_app_frontend/features/home/widgets/home_quick_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Home Header
              HomeHeader(),

              // Highlight Banner
              SizedBox(height: 16),
              HomeHighlightBanner(),

              // Quick Menu
              SizedBox(height: 32),
              HomeQuickMenu(),

              // Announcement Section
              SizedBox(height: 32),
              HomeAnnouncementSection(),

              // Job Section
              SizedBox(height: 32),
              HomeJobSection(),

              // Event Section
              SizedBox(height: 32),
              HomeEventSection(),
            ],
          ),
        ),
      ),
    );
  }
}
