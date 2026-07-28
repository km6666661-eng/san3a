import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class StepIndicator extends StatelessWidget {
  final int activeStep;
  final String label;

  const StepIndicator({
    super.key,
    this.activeStep = 1,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          child: Row(
            children: [
              _stepCircle(step: 1),
              Expanded(child: _stepLine(step: 1)),
              _stepCircle(step: 2),
              Expanded(child: _stepLine(step: 2)),
              _stepCircle(step: 3),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _stepCircle({required int step}) {
    if (step < activeStep) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, size: 14, color: Colors.white),
      );
    } else if (step == activeStep) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }
  }

  Widget _stepLine({required int step}) {
    return Container(
      height: 2,
      color: step < activeStep ? AppColors.primary : AppColors.borderLight,
    );
  }
}
