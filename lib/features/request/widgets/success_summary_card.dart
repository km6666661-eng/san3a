import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class SuccessSummaryCard extends StatelessWidget {
  const SuccessSummaryCard({super.key});

  static const List<_SuccessRow> _rows = [
    _SuccessRow(label: 'رقم الطلب', value: '1074-2025'),
    _SuccessRow(label: 'الفئة', value: 'نجارة'),
    _SuccessRow(label: 'الميزانية', value: '200 - 500 ج'),
    _SuccessRow(label: 'مستوى الإلحاح', value: 'عادي'),
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
        children: _rows.map((row) => Padding(
          padding: EdgeInsets.only(bottom: row == _rows.last ? 0 : 14),
          child: Row(
            children: [
              Text(
                row.value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Spacer(),
              Text(
                row.label,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }
}

class _SuccessRow {
  final String label;
  final String value;

  const _SuccessRow({required this.label, required this.value});
}
