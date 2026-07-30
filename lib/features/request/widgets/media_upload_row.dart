import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import 'dash_border_painter.dart';

class MediaUploadRow extends StatelessWidget {
  const MediaUploadRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _selectedImageCard()),
        SizedBox(width: 10),
        Expanded(child: _uploadCard(icon: Icons.videocam, label: 'فيديو')),
        SizedBox(width: 10),
        Expanded(child: _uploadCard(icon: Icons.camera_alt, label: 'صورة')),
      ],
    );
  }

  Widget _selectedImageCard() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: AppRadius.lgAll,
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.image_outlined,
              size: 32,
              color: Color(0xFF4CAF50),
            ),
          ),
          Positioned(
            top: 6,
            left: 6,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, size: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uploadCard({required IconData icon, required String label}) {
    return Container(
      height: 100,
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
              Icon(icon, size: 26, color: AppColors.primary),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
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
