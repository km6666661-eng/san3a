import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/onboarding_illustration.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    super.key,
    required this.title,
    required this.description,
    required this.illustrationIcon,
    this.illustrationBgColor,
  });

  final String title;
  final String description;
  final IconData illustrationIcon;
  final Color? illustrationBgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
      ),
      child: Column(
        children: [
          const Spacer(flex: 2),
          OnboardingIllustration(
            icon: illustrationIcon,
            size: 260,
            backgroundColor: illustrationBgColor ?? AppColors.primaryLight,
          ),
          const Spacer(flex: 2),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.7,
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
