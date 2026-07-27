import 'package:flutter/material.dart';
import 'app_shared.dart';
import 'package:san3a/elfany_details/search_screen.dart';

class BottomNav extends StatelessWidget {
  final String activeLabel;

  const BottomNav({super.key, this.activeLabel = 'الرئيسية'});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, 'الرئيسية'),
      (Icons.search, 'بحث'),
      (Icons.receipt_long_outlined, 'طلباتي'),
      (Icons.notifications_outlined, 'إشعارات'),
      (Icons.person_outline, 'حسابي'),
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
          final (icon, label) = item;
          final active = label == activeLabel;
          final color = active ? AppColors.blue1 : AppColors.textMute;
          return GestureDetector(
            onTap: () {
              if (active) return; // already on this tab

              if (label == 'الرئيسية') {
                Navigator.popUntil(context, (route) => route.isFirst);
              } else if (label == 'بحث') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                );
              } else {
                goTo(context, label);
              }
            },
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
  }}