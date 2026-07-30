import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class VoiceRecorder extends StatelessWidget {
  const VoiceRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mic, size: 22, color: Colors.white),
          ),
          Expanded(
            child: Center(
              child: Text(
                'اضغط للتسجيل (حتى 30 ثانية)',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
