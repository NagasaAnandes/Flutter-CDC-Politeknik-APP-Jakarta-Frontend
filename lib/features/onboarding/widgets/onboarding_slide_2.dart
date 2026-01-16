import 'package:flutter/material.dart';
import 'onboarding_background.dart';
import 'onboarding_hero_slide.dart';

class OnboardingSlide2 extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingSlide2({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return OnboardingBackground(
      image: 'assets/images/Gedung_Poltekapp.jpg',
      child: OnboardingHeroSlide(
        heroImage: 'assets/images/Mahasiswa_1.png',
        title: 'Lowongan Terverifikasi',
        description:
            'Akses lowongan kerja dan magang yang telah dikurasi langsung oleh CDC.',
        cta: ElevatedButton(onPressed: onNext, child: const Text('Lanjut')),
      ),
    );
  }
}
