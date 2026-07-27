import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'primary_button.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
    this.primaryColor,
    this.isPrimaryEnabled = true,
  });

  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final Color? primaryColor;
  final bool isPrimaryEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (secondaryLabel != null && onSecondaryPressed != null) ...[
              PrimaryButton(
                text: primaryLabel,
                onPressed: isPrimaryEnabled ? onPrimaryPressed : null,
                isEnabled: isPrimaryEnabled,
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: onSecondaryPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.borderLight),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.xlAll,
                    ),
                  ),
                  child: Text(
                    secondaryLabel!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ] else
              PrimaryButton(
                text: primaryLabel,
                onPressed: isPrimaryEnabled ? onPrimaryPressed : null,
                isEnabled: isPrimaryEnabled,
              ),
          ],
        ),
      ),
    );
  }
}
