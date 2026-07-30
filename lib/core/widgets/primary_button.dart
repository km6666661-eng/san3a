import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.width = double.infinity,
    this.height = 56,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.primary : AppColors.borderLight,
          foregroundColor: isEnabled ? Colors.white : AppColors.textHint,
          disabledBackgroundColor: AppColors.borderLight,
          disabledForegroundColor: AppColors.textHint,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxxl,
            vertical: AppSpacing.lg,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.xlAll,
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isEnabled ? Colors.white : AppColors.textHint,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
