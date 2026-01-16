import 'package:flutter/material.dart';
import 'onboarding_background.dart';
import 'onboarding_hero_slide.dart';

class OnboardingSlide1 extends StatelessWidget {
  final VoidCallback onNext;

  const OnboardingSlide1({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return OnboardingBackground(
      image: 'assets/images/Gedung_Poltekapp.jpg',
      child: OnboardingHeroSlide(
        heroImage: 'assets/images/Mahasiswa_1.png',
        title: 'Official Career Gateway',
        description: 'Politeknik APP Jakarta',
        cta: ElevatedButton(onPressed: onNext, child: const Text('Lanjut')),
      ),
    );
  }
}
