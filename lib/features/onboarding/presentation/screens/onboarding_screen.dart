import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/animated_page_indicator.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/skip_button.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/account_type_screen.dart';
import '../widgets/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _totalPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage >= _totalPages - 1) return;
    _pageController.animateToPage(
      _currentPage + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _skipToLastPage() {
    _pageController.animateToPage(
      _totalPages - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isLastPage => _currentPage == _totalPages - 1;

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
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
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
          if (!_isLastPage)
            SkipButton(text: AppStrings.skip, onPressed: _skipToLastPage)
          else
            const SizedBox(width: 80),
          Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedPageIndicator(
              currentPage: _currentPage,
              totalPages: _totalPages,
            ),
          ),
          const SizedBox(width: 80),
        ],
      ),
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    OnboardingProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageHorizontal,
        0,
        AppSpacing.pageHorizontal,
        AppSpacing.pageBottom,
      ),
      child: _isLastPage
          ? _buildLastPageButton(context, provider)
          : _buildNavigationButton(),
    );
  }

  Widget _buildNavigationButton() {
    return PrimaryButton(text: AppStrings.next, onPressed: _goToNextPage);
  }

  Widget _buildLastPageButton(
    BuildContext context,
    OnboardingProvider provider,
  ) {
    return PrimaryButton(
      text: AppStrings.continueText,
      isEnabled: provider.isAccountSelected,
      onPressed: () async {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.login, arguments: provider.selectedAccountType);
      },
    );
  }
}
