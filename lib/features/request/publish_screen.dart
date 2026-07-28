import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import 'success_screen.dart';
import 'widgets/file_upload_area.dart';
import 'widgets/media_upload_row.dart';
import 'widgets/request_summary_card.dart';
import 'widgets/step_indicator.dart';
import 'widgets/voice_recorder.dart';

class PublishScreen extends StatelessWidget {
  const PublishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.borderLight.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal,
              ),
              child: Column(
                children: [
                  Center(
                    child: StepIndicator(
                      activeStep: 3,
                      label: 'الوسائط والنشر',
                    ),
                  ),
                  SizedBox(height: 28),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('صور المشكلة (اختياري)'),
                        SizedBox(height: 12),
                        MediaUploadRow(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('رسالة صوتية للفني (اختياري)'),
                        SizedBox(height: 12),
                        VoiceRecorder(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('مرفقات إضافية'),
                        SizedBox(height: 12),
                        FileUploadArea(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  RequestSummaryCard(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _bottomButton(context),
        ],
      ),
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pageHorizontal,
        AppSpacing.md,
        AppSpacing.pageHorizontal,
        AppSpacing.pageBottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const SuccessScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentOrange,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(27),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text('نشر الطلب الآن'),
          ),
        ),
      ),
    );
  }
}
