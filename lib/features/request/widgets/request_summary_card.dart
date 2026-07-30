import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({super.key});

  static const List<_SummaryRow> _rows = [
    _SummaryRow(label: 'العنوان:', value: 'إصلاح تسريب في الحمام'),
    _SummaryRow(label: 'الفئة:', value: 'نجارة'),
    _SummaryRow(label: 'الميزانية:', value: '200 - 500 ج'),
    _SummaryRow(label: 'الموعد:', value: 'الثلاثاء 21 - 10:00 ص'),
    _SummaryRow(label: 'الإلحاح:', value: 'عادي'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'ملخص الطلب قبل النشر',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          ..._rows.map((row) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    row.value,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  row.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _SummaryRow {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});
}
