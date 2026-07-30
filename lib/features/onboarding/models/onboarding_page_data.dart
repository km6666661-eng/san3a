import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.illustration,
    this.isLast = false,
  });

  final String title;
  final String description;
  final IconData illustration;
  final bool isLast;
}
