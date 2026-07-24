import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';

abstract final class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (_) => const OnboardingScreen(),
    };
  }
}
