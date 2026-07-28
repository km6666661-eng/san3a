import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class DaySelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const DaySelector({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const List<Map<String, String>> _days = [
    {'day': 'الاثنين', 'date': '20'},
    {'day': 'الثلاثاء', 'date': '21'},
    {'day': 'الأربعاء', 'date': '22'},
    {'day': 'الخميس', 'date': '23'},
    {'day': 'الجمعة', 'date': '24'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, _) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = _days[index];
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              width: 62,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: AppRadius.mdAll,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.borderLight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['day']!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    item['date']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
