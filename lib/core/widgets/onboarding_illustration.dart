import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({
    super.key,
    required this.icon,
    this.size = 240,
    this.backgroundColor,
  });

  final IconData icon;
  final double size;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size * 0.45,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
