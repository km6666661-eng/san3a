import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class CategoryGrid extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryGrid({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const List<_CategoryData> _categories = [
    _CategoryData(name: 'سباكة', icon: Icons.plumbing),
    _CategoryData(name: 'كهرباء', icon: Icons.electrical_services),
    _CategoryData(name: 'تكييف', icon: Icons.ac_unit),
    _CategoryData(name: 'دهانات', icon: Icons.format_paint),
    _CategoryData(name: 'تنظيف', icon: Icons.cleaning_services),
    _CategoryData(name: 'نجارة', icon: Icons.handyman),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final cat = _categories[index];
        final isSelected = selected == cat.name;
        return GestureDetector(
          onTap: () => onSelected(cat.name),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(0xFFFFF5EB)
                  : AppColors.surface,
              borderRadius: AppRadius.lgAll,
              border: Border.all(
                color: isSelected
                    ? AppColors.accentOrange
                    : AppColors.borderLight,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accentOrange.withValues(alpha: 0.15)
                        : Color(0xFFF8F9FA),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    cat.icon,
                    size: 18,
                    color: isSelected
                        ? AppColors.accentOrange
                        : AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  cat.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.accentOrange
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryData {
  final String name;
  final IconData icon;

  const _CategoryData({required this.name, required this.icon});
}
