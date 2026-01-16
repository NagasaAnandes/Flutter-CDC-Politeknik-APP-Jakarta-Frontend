import 'package:flutter/material.dart';
import 'onboarding_background.dart';
import 'onboarding_hero_slide.dart';

class OnboardingSlide3 extends StatelessWidget {
  final VoidCallback onFinish;

  const OnboardingSlide3({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return OnboardingBackground(
      image: 'assets/images/Gedung_Poltekapp.jpg',
      child: OnboardingHeroSlide(
        heroImage: 'assets/images/Mahasiswa_1.png',
        title: 'Bangun Kariermu',
        description:
            'Ikuti event, isi tracer study, dan kelola perjalanan kariermu.',
        cta: ElevatedButton(onPressed: onFinish, child: const Text('Mulai')),
      ),
    );
  }
}
