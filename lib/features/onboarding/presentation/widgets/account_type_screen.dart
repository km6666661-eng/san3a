import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/account_type_card.dart';
import '../../models/account_type_model.dart';
import '../../../../core/constants/constants.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  static final List<AccountTypeModel> _accountTypes = [
    const AccountTypeModel(
      type: AccountType.customer,
      title: AppStrings.customerTitle,
      description: AppStrings.customerDescription,
      icon: Icons.home_rounded,
    ),
    const AccountTypeModel(
      type: AccountType.technician,
      title: AppStrings.technicianTitle,
      description: AppStrings.technicianDescription,
      icon: Icons.build_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal,
          ),
          child: Column(
            children: [
              const Spacer(flex: 1),
              const Text(
                AppStrings.accountTypeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const Spacer(flex: 1),
              ...List.generate(_accountTypes.length, (index) {
                final account = _accountTypes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: AccountTypeCard(
                    account: account,
                    isSelected:
                        provider.selectedAccountType == account.type,
                    onTap: () =>
                        provider.selectAccountType(account.type),
                  ),
                );
              }),
              const Spacer(flex: 2),
            ],
          ),
        );
      },
    );
  }
}
