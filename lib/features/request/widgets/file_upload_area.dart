import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import 'dash_border_painter.dart';

class FileUploadArea extends StatelessWidget {
  const FileUploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: CustomPaint(
          painter: DashBorderPainter(
            color: AppColors.primary.withValues(alpha: 0.4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 32,
                color: AppColors.primary,
              ),
              SizedBox(height: 8),
              Text(
                'رفع ملفات PDF أو مستندات',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
