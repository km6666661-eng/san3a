import 'package:flutter/material.dart';
import '../../models/account_type_model.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentPage = 0;
  AccountType _selectedAccountType = AccountType.none;

  // Explicitly start at page 0 so the first page is the left-most page.
  final PageController _pageController = PageController(initialPage: 0);

  OnboardingProvider() {
    // Keep provider in sync with programmatic and swipe changes.
    _pageController.addListener(() {
      final page = (_pageController.page ?? 0).round();
      if (page != _currentPage) {
        _currentPage = page;
        notifyListeners();
      }
    });
  }

  int get currentPage => _currentPage;
  AccountType get selectedAccountType => _selectedAccountType;
  PageController get pageController => _pageController;

  bool get isLastPage => _currentPage == 3;
  bool get isAccountSelected => _selectedAccountType != AccountType.none;

  void setPage(int index) {
    // Keep the provider state deterministic when the PageView reports a page change.
    if (_currentPage != index) {
      _currentPage = index;
      notifyListeners();
    }
  }

  void selectAccountType(AccountType type) {
    if (_selectedAccountType == type) {
      _selectedAccountType = AccountType.none;
    } else {
      _selectedAccountType = type;
    }
    notifyListeners();
  }

  void nextPage(int totalPages) {
    // Explicitly compute the target page on the right and animate to it. This makes
    // the navigation behavior clear and independent of ambient Directionality.
    final target = (_currentPage < totalPages - 1) ? _currentPage + 1 : _currentPage;
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void skipToLast(int totalPages) {
    // Jump immediately to the right-most (last) page as requested.
    _pageController.jumpToPage(totalPages - 1);
    // Update local state immediately so UI reflects the skip action.
    setPage(totalPages - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
