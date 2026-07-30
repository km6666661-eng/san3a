import 'package:flutter/material.dart';

import '../features/onboarding/presentation/screens/bottom_nav.dart';
import 'booking_details_screen.dart';
import 'technician_profile_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String? initialQuery;
  final String? initialCategory;

  const SearchResultsScreen({
    super.key,
    this.initialQuery,
    this.initialCategory,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  // الفلتر المختار حالياً — بس شكل بصري، مش بيغيّر ترتيب/محتوى القايمة
  String _selectedFilter = 'التقييم';
  final List<String> _filters = const [
    'التقييم',
    'السعر',
    'المسافة',
    'التعليقات',
  ];

  @override
  Widget build(BuildContext context) {
    final String? headerLabel = widget.initialCategory ?? widget.initialQuery;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F8),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 12, bottom: 16),
              child: Column(
                children: [
                  // App Bar Row - السهم في أقصى الشمال
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // أقصى الشمال في RTL
                      children: [
                        InkWell(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEBF3FE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFF1D61E7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Divider(
                    color: Color(0xFFE8EEF8),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 12),

                  // Filter Chips Row — دلوقتي بتتداس وبتبدّل الاختيار، والقايمة تحتها فاضلة زي ما هي
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        for (int i = 0; i < _filters.length; i++) ...[
                          FilterChipWidget(
                            label: _filters[i],
                            isSelected: _selectedFilter == _filters[i],
                            onTap: () =>
                                setState(() => _selectedFilter = _filters[i]),
                          ),
                          if (i != _filters.length - 1)
                            const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Results Content Area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                children: [
                  // Results Count — بيعكس اللي اتبعت من السكرين الأول لو موجود
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      headerLabel != null
                          ? 'نتائج البحث عن "$headerLabel"'
                          : '5 فني متاح قريب منك',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Provider Cards
                  const ProviderCard(
                    name: 'أحمد حسن',
                    profession: 'سباكة',
                    rating: '4.9',
                    reviewCount: '١٣٤٢',
                    completedJobs: '1240+ مهمة',
                    distance: '1.2 كم',
                    statusText: 'متاح الآن',
                    isAvailable: true,
                    price: '150',
                    isOnline: true,
                    imageUrl:
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
                  ),
                  const SizedBox(height: 12),

                  const ProviderCard(
                    name: 'محمد علي',
                    profession: 'كهرباء',
                    rating: '4.8',
                    reviewCount: '٢١٨',
                    completedJobs: '890+ مهمة',
                    distance: '0.8 كم',
                    statusText: 'متاح الآن',
                    isAvailable: true,
                    price: '180',
                    isOnline: true,
                    imageUrl:
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
                  ),
                  const SizedBox(height: 12),

                  const ProviderCard(
                    name: 'خالد عمر',
                    profession: 'تكييف',
                    rating: '4.7',
                    reviewCount: '١٩٠',
                    completedJobs: '720+ مهمة',
                    distance: '2.1 كم',
                    statusText: 'مشغول',
                    isAvailable: false,
                    price: '220',
                    isOnline: false,
                    imageUrl:
                        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=150',
                  ),
                  const SizedBox(height: 12),

                  const ProviderCard(
                    name: 'يوسف سمير',
                    profession: 'دهانات',
                    rating: '4.6',
                    reviewCount: '١٦٧',
                    completedJobs: '540+ مهمة',
                    distance: '3.5 كم',
                    statusText: 'متاح الآن',
                    isAvailable: true,
                    price: '130',
                    isOnline: false,
                    imageUrl:
                        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
                  ),
                  const SizedBox(height: 12),

                  const ProviderCard(
                    name: 'كريم إبراهيم',
                    profession: 'نجارة',
                    rating: '4.8',
                    reviewCount: '٢٠١٣',
                    completedJobs: '680+ مهمة',
                    distance: '1.8 كم',
                    statusText: 'متاح الآن',
                    isAvailable: true,
                    price: '130',
                    isOnline: true,
                    imageUrl:
                        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar — shared widget, same one used across the app
      bottomNavigationBar: const BottomNav(),
    );
  }
}

// Filter Chip Widget — دلوقتي قابل للدوس
class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D61E7) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFCBD5E1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF1D61E7),
          ),
        ),
      ),
    );
  }
}

// Provider Card Widget
class ProviderCard extends StatelessWidget {
  final String name;
  final String profession;
  final String rating;
  final String reviewCount;
  final String completedJobs;
  final String distance;
  final String statusText;
  final bool isAvailable;
  final String price;
  final bool isOnline;
  final String imageUrl;

  const ProviderCard({
    super.key,
    required this.name,
    required this.profession,
    required this.rating,
    required this.reviewCount,
    required this.completedJobs,
    required this.distance,
    required this.statusText,
    required this.isAvailable,
    required this.price,
    required this.isOnline,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProviderProfileScreen(
              name: name,
              profession: profession,
              rating: rating,
              reviewCount: reviewCount,
              completedJobs: completedJobs,
              price: price,
              imageUrl: imageUrl,
              isAvailable: isAvailable,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 64,
                      height: 64,
                      color: const Color(0xFFCBD5E1),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Verification Icon
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.verified_outlined,
                            size: 16,
                            color: Color(0xFF1D61E7),
                          ),
                        ],
                      ),

                      // Profession
                      Text(
                        profession,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Rating Stars & Review Count
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star_rounded,
                                size: 19,
                                color: Color(0xFFF97316),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$rating ($reviewCount)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF1D61E7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      const Divider(
                        color: Color(0xFFF1F5F9),
                        thickness: 1,
                        height: 12,
                      ),

                      // Info Row
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            distance,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 10),

                          const Icon(
                            Icons.workspace_premium_outlined,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            completedJobs,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 10),

                          Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isAvailable
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Bottom Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: isOnline
                                      ? const Color(0xFF16A34A)
                                      : const Color(0xFF94A3B8),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 20),

                              Row(
                                children: [
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const Text(
                                    ' ج/ساعة',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Button
                          GestureDetector(
                            onTap: isAvailable
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BookingScreen(
                                          technicianName: name,
                                          profession: profession,
                                          rating: rating,
                                          price: price,
                                          imageUrl: imageUrl,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: isAvailable
                                    ? const Color(0xFF1D61E7)
                                    : const Color(0xFFCBD5E1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'احجز',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Favorite Button
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEAD5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 17,
                  color: Color(0xFFF97316),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
