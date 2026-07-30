import 'package:flutter/material.dart';

class AppColors {
  static const blue1 = Color(0xFF2547E0);
  static const blue2 = Color(0xFF1B33A8);
  static const orange1 = Color(0xFFFF7A1A);
  static const orange2 = Color(0xFFFF5A1F);
  static const bg = Color(0xFFF3F5FA);
  static const card = Colors.white;
  static const textDark = Color(0xFF161A34);
  static const textMid = Color(0xFF5B6178);
  static const textMute = Color(0xFF9297AC);
  static const green = Color(0xFF22C55E);
  static const gold = Color(0xFFFFB020);

  static const bgPaintBg = Color(0xFFEFE6FF);
  static const bgPaintFg = Color(0xFF8A4DFF);
  static const bgAcBg = Color(0xFFDFF6FA);
  static const bgAcFg = Color(0xFF12A6C4);
  static const bgElecBg = Color(0xFFFFF3D6);
  static const bgElecFg = Color(0xFFE8A400);
  static const bgPlumbBg = Color(0xFFDCE7FF);
  static const bgPlumbFg = Color(0xFF3266E8);
  static const bgNetBg = Color(0xFFD8F5EC);
  static const bgNetFg = Color(0xFF0FA875);
  static const bgMaintBg = Color(0xFFEAEAF2);
  static const bgMaintFg = Color(0xFF6B7086);
  static const bgCleanBg = Color(0xFFDFF3E4);
  static const bgCleanFg = Color(0xFF2AAE58);
  static const bgCarpBg = Color(0xFFFFE4D6);
  static const bgCarpFg = Color(0xFFE56A2C);
}

void goTo(BuildContext context, String pageName) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('سيتم فتح صفحة: $pageName', textAlign: TextAlign.right),
      backgroundColor: AppColors.textDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(bottom: 90, left: 40, right: 40),
      duration: const Duration(milliseconds: 1400),
    ),
  );
}

class ServiceCategory {
  final String label;
  final String key;
  final IconData icon;
  final Color bg;
  final Color fg;
  const ServiceCategory(this.label, this.key, this.icon, this.bg, this.fg);
}

class Technician {
  final String name;
  final String category;
  final int price;
  final double rating;
  final String reviews;
  final String distance;
  final String photo;
  const Technician({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.photo,
  });
}

class OfferData {
  final String title;
  final String category;
  final String discount;
  final String image;
  const OfferData(this.title, this.category, this.discount, this.image);
}

const List<ServiceCategory> kServices = [
  ServiceCategory(
    'دهانات',
    'دهانات',
    Icons.format_paint_outlined,
    AppColors.bgPaintBg,
    AppColors.bgPaintFg,
  ),
  ServiceCategory(
    'تكييف',
    'تكييف',
    Icons.ac_unit_outlined,
    AppColors.bgAcBg,
    AppColors.bgAcFg,
  ),
  ServiceCategory(
    'كهرباء',
    'كهرباء',
    Icons.bolt_outlined,
    AppColors.bgElecBg,
    AppColors.bgElecFg,
  ),
  ServiceCategory(
    'سباكة',
    'سباكة',
    Icons.plumbing_outlined,
    AppColors.bgPlumbBg,
    AppColors.bgPlumbFg,
  ),
  ServiceCategory(
    'إنترنت وشبكات',
    'إنترنت',
    Icons.wifi_outlined,
    AppColors.bgNetBg,
    AppColors.bgNetFg,
  ),
  ServiceCategory(
    'صيانة أجهزة',
    'صيانة',
    Icons.settings_outlined,
    AppColors.bgMaintBg,
    AppColors.bgMaintFg,
  ),
  ServiceCategory(
    'تنظيف',
    'تنظيف',
    Icons.cleaning_services_outlined,
    AppColors.bgCleanBg,
    AppColors.bgCleanFg,
  ),
  ServiceCategory(
    'نجارة',
    'نجارة',
    Icons.carpenter_outlined,
    AppColors.bgCarpBg,
    AppColors.bgCarpFg,
  ),
];

const List<Technician> kTechnicians = [
  Technician(
    name: 'ابرام انور ',
    category: 'سباكة',
    price: 150,
    rating: 4.9,
    reviews: '(342)',
    distance: '1.2 كم',
    photo:
        'https://images.pexels.com/photos/30767572/pexels-photo-30767572.jpeg',
  ),
  Technician(
    name: 'محمد علي',
    category: 'كهرباء',
    price: 180,
    rating: 4.8,
    reviews: '(218)',
    distance: '0.8 كم',
    photo:
        'https://images.pexels.com/photos/12437056/pexels-photo-12437056.jpeg',
  ),
  Technician(
    name: 'كريم عادل',
    category: 'تكييف',
    price: 200,
    rating: 4.7,
    reviews: '(156)',
    distance: '2.1 كم',
    photo:
        'https://images.pexels.com/photos/17842834/pexels-photo-17842834.jpeg',
  ),
  Technician(
    name: 'منى سمير',
    category: 'تنظيف',
    price: 120,
    rating: 4.9,
    reviews: '(410)',
    distance: '1.5 كم',
    photo:
        'https://images.pexels.com/photos/34381970/pexels-photo-34381970.jpeg',
  ),
  Technician(
    name: 'يوسف إبراهيم',
    category: 'نجارة',
    price: 170,
    rating: 4.6,
    reviews: '(97)',
    distance: '3.0 كم',
    photo:
        'https://images.pexels.com/photos/30767572/pexels-photo-30767572.jpeg',
  ),
  Technician(
    name: 'عمر سامح',
    category: 'إنترنت',
    price: 160,
    rating: 4.8,
    reviews: '(133)',
    distance: '1.9 كم',
    photo:
        'https://images.pexels.com/photos/12437056/pexels-photo-12437056.jpeg',
  ),
  Technician(
    name: 'حسام فتحي',
    category: 'صيانة',
    price: 140,
    rating: 4.7,
    reviews: '(88)',
    distance: '2.4 كم',
    photo:
        'https://images.pexels.com/photos/17842834/pexels-photo-17842834.jpeg',
  ),
  Technician(
    name: 'مصطفى كامل',
    category: 'دهانات',
    price: 190,
    rating: 4.5,
    reviews: '(64)',
    distance: '2.7 كم',
    photo:
        'https://images.pexels.com/photos/30767572/pexels-photo-30767572.jpeg',
  ),
];

const List<OfferData> kOffers = [
  OfferData(
    'تنظيف شامل',
    'تنظيف',
    'خصم 15%',
    'https://images.pexels.com/photos/6196566/pexels-photo-6196566.jpeg',
  ),
  OfferData(
    'صيانة التكييف',
    'تكييف',
    'خصم 20%',
    'https://images.pexels.com/photos/5463581/pexels-photo-5463581.jpeg',
  ),
];
