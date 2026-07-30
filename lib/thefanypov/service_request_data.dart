import 'package:flutter/material.dart';

// ============================================================
// URGENCY BADGE TYPE
// ============================================================
enum RequestUrgency { urgent, normal, flexible }

extension RequestUrgencyX on RequestUrgency {
  String get label {
    switch (this) {
      case RequestUrgency.urgent:
        return 'عاجل';
      case RequestUrgency.normal:
        return 'عادي';
      case RequestUrgency.flexible:
        return 'مرن';
    }
  }

  Color get bg {
    switch (this) {
      case RequestUrgency.urgent:
        return const Color(0xFFFFE2E2);
      case RequestUrgency.normal:
        return const Color(0xFFE3ECFF);
      case RequestUrgency.flexible:
        return const Color(0xFFEDE3FF);
    }
  }

  Color get fg {
    switch (this) {
      case RequestUrgency.urgent:
        return const Color(0xFFE0333F);
      case RequestUrgency.normal:
        return const Color(0xFF3A6FF7);
      case RequestUrgency.flexible:
        return const Color(0xFF8B4FE0);
    }
  }
}

// ============================================================
// MODEL
// ============================================================
class ServiceRequest {
  final String id;
  final RequestUrgency urgency;
  final String title;
  final String location;
  final String priceRange; // e.g. "200-400"
  final String photo;
  final String providerName;
  final String tierLabel; // small badge shown on the avatar corner
  final Color tierColor;
  final double rating;
  final int offersCount;
  final String description;
  final String category; // used for filtering by the chip bar

  const ServiceRequest({
    required this.id,
    required this.urgency,
    required this.title,
    required this.location,
    required this.priceRange,
    required this.photo,
    required this.providerName,
    required this.tierLabel,
    required this.tierColor,
    required this.rating,
    required this.offersCount,
    required this.description,
    required this.category,
  });
}

// ============================================================
// FILTER CHIPS FOR THIS SECTION
// key must match ServiceRequest.category
// ============================================================
class RequestFilter {
  final String key;
  final String label;
  const RequestFilter({required this.key, required this.label});
}

const List<RequestFilter> kRequestFilters = [
  RequestFilter(key: 'all', label: 'الكل'),
  RequestFilter(key: 'plumbing', label: 'سباكة'),
  RequestFilter(key: 'electricity', label: 'كهرباء'),
  RequestFilter(key: 'ac', label: 'تكييف'),
  RequestFilter(key: 'paint', label: 'دهانات'),
  RequestFilter(key: 'carpentry', label: 'نجارة'),
];

// ============================================================
// SAMPLE DATA (matches the reference screens)
// ============================================================
const List<ServiceRequest> kServiceRequests = [
  ServiceRequest(
    id: 'r1',
    urgency: RequestUrgency.urgent,
    title: 'إصلاح تسريب مياه في الحمام',
    location: 'مدينة نصر',
    priceRange: '200-400',
    photo: 'https://i.pravatar.cc/150?img=12',
    providerName: 'عمر ناصر',
    tierLabel: '٤',
    tierColor: Color(0xFF2AB6A8),
    rating: 4.8,
    offersCount: 5,
    description:
        'يوجد تسريب في أنبوب الحمام الرئيسي يسبب تلف الأرضية. أحتاج فنيًا سريعًا.',
    category: 'plumbing',
  ),
  ServiceRequest(
    id: 'r2',
    urgency: RequestUrgency.normal,
    title: 'تركيب مكيف جديد في الغرفة',
    location: 'المعادي',
    priceRange: '500-900',
    photo: 'https://i.pravatar.cc/150?img=32',
    providerName: 'سارة أحمد',
    tierLabel: 'س',
    tierColor: Color(0xFF3A6FF7),
    rating: 4.9,
    offersCount: 3,
    description:
        'مكيف 1.5 حصان لم يُركب. أحتاج تركيبه مع اختبار التشغيل الكامل.',
    category: 'ac',
  ),
  ServiceRequest(
    id: 'r3',
    urgency: RequestUrgency.flexible,
    title: 'صباغة صالة الجلوس بالكامل',
    location: 'الزيتون',
    priceRange: '300-600',
    photo: 'https://i.pravatar.cc/150?img=51',
    providerName: 'محمد كريم',
    tierLabel: 'P',
    tierColor: Color(0xFF3A6FF7),
    rating: 4.6,
    offersCount: 7,
    description:
        'الصالة 40 م². أريد لونًا محايدًا، والشغل يشمل تجهيز الأسطح والطلاء طبقتين.',
    category: 'paint',
  ),
  ServiceRequest(
    id: 'r4',
    urgency: RequestUrgency.urgent,
    title: 'إصلاح أعطال كهربائية متعددة',
    location: 'مصر الجديدة',
    priceRange: '150-300',
    photo: 'https://i.pravatar.cc/150?img=45',
    providerName: 'نورا سامي',
    tierLabel: '٥',
    tierColor: Color(0xFFE0333F),
    rating: 5.0,
    offersCount: 4,
    description:
        'انقطاع في التيار بغرفة النوم وبعض المفاتيح لا تعمل منذ أمس.',
    category: 'electricity',
  ),
];