import 'package:flutter/material.dart';
import 'app_shared.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, 'الرئيسية', true),
      (Icons.search, 'بحث', false),
      (Icons.receipt_long_outlined, 'طلباتي', false),
      (Icons.notifications_outlined, 'إشعارات', false),
      (Icons.person_outline, 'حسابي', false),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final (icon, label, active) = item;
          final color = active ? AppColors.blue1 : AppColors.textMute;
          return GestureDetector(
            onTap: () => goTo(context, label),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: active ? AppColors.blue1.withOpacity(0.1) : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
