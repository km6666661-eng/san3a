import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Center(
        child: Icon(
          Icons.map_outlined,
          size: 32,
          color: AppColors.textHint,
        ),
      ),
    );
  }
}
