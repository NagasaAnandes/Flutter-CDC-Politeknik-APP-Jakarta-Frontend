import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization work
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.goNamed('onboarding');
      // Navigate to the next page (e.g., HomePage or OnboardingPage)
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('CDC Poltek App Splash Screen')),
    );
  }
}
