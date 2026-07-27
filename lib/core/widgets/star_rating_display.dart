import 'package:flutter/material.dart';
import '../constants/constants.dart';

class StarRatingDisplay extends StatelessWidget {
  const StarRatingDisplay({
    super.key,
    required this.rating,
    this.size = 14,
    this.showValue = true,
    this.color,
  });

  final double rating;
  final double size;
  final bool showValue;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? AppColors.star;

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        if (showValue) ...[
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size - 2,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        ...List.generate(5, (index) {
          final filled = index < rating.floor();
          final half = !filled && index < rating.ceil() && rating % 1 >= 0.5;
          return Icon(
            filled
                ? Icons.star_rounded
                : half
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
            color: starColor,
            size: size,
          );
        }),
      ],
    );
  }
}
