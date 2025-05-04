import 'package:flutter/material.dart';
import 'package:voca_grow_app/features/splash/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: const SplashBody()));
  }
}
