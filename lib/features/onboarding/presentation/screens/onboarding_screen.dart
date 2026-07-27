import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_page_content.dart';
import '../widgets/account_type_screen.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/animated_page_indicator.dart';
import '../../models/account_type_model.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/skip_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const int _totalPages = 4;

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(provider),
                Expanded(
                  child: PageView(
                    reverse: true,
                    controller: provider.pageController,
                    onPageChanged: provider.setPage,
                    children: const [
                      OnboardingPageContent(
                        title: AppStrings.welcomeTitle,
                        description: AppStrings.welcomeDescription,
                        illustrationIcon: Icons.home_rounded,
                      ),
                      OnboardingPageContent(
                        title: AppStrings.findWorkersTitle,
                        description: AppStrings.findWorkersDescription,
                        illustrationIcon: Icons.person_search_rounded,
                        illustrationBgColor: Color(0xFFECFDF5),
                      ),
                      OnboardingPageContent(
                        title: AppStrings.bookingTitle,
                        description: AppStrings.bookingDescription,
                        illustrationIcon: Icons.calendar_month_rounded,
                        illustrationBgColor: Color(0xFFFFF7ED),
                      ),
                      AccountTypeScreen(),
                    ],
                  ),
                ),
                _buildBottomSection(context, provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!provider.isLastPage)
            SkipButton(
              text: AppStrings.skip,
              onPressed: () => provider.skipToLast(_totalPages),
            )
          else
            const SizedBox(width: 80),
          Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedPageIndicator(
              currentPage: provider.currentPage,
              totalPages: _totalPages,
            ),
          ),
          const SizedBox(width: 80),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageHorizontal,
        0,
        AppSpacing.pageHorizontal,
        AppSpacing.pageBottom,
      ),
      child: provider.isLastPage
          ? _buildLastPageButton(context, provider)
          : _buildNavigationButton(provider),
    );
  }

  Widget _buildNavigationButton(OnboardingProvider provider) {
    return PrimaryButton(
      text: AppStrings.next,
      onPressed: () => provider.nextPage(_totalPages),
    );
  }

  Widget _buildLastPageButton(BuildContext context, OnboardingProvider provider) {
    return PrimaryButton(
      text: AppStrings.continueText,
      isEnabled: provider.isAccountSelected,
      onPressed: () {
        // Go to Login first; pass along the chosen account type so that
        // Login's "Create account" link routes to the right sign-up flow.
        Navigator.of(context).pushNamed(
          AppRoutes.login,
          arguments: provider.selectedAccountType,
        );
      },
    );
  }
}