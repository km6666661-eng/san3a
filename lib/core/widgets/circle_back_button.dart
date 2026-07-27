import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
    this.onPressed,
    this.icon = Icons.arrow_forward_ios,
    this.backgroundColor,
    this.iconColor,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryLight.withValues(alpha: 0.6),
        shape: BoxShape.circle,
        boxShadow: AppShadows.light,
      ),
      child: IconButton(
        icon: Icon(icon, size: 16, color: iconColor ?? AppColors.textPrimary),
        onPressed: onPressed ?? () => Navigator.maybePop(context),
      ),
    );
  }
}
