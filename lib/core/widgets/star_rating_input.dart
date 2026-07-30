import 'package:flutter/material.dart';
import '../constants/constants.dart';

class StarRatingInput extends StatelessWidget {
  const StarRatingInput({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.size = 40,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isSelected = starIndex <= rating;

        return GestureDetector(
          onTap: () => onRatingChanged(starIndex),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            transform: Matrix4.identity()
              ..scale(isSelected && starIndex == rating ? 1.15 : 1.0),
            child: Icon(
              isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
              color: isSelected ? AppColors.star : AppColors.textHint,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
