import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFFDBEAFE);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryWithOpacity = Color(0x1A2563EB);

  // Background
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF8FAFC);

  // Text
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);

  // Border
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderFocus = Color(0xFF2563EB);

  // Shadows
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x14000000);
}
