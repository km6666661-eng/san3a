import 'package:flutter/material.dart';
import 'package:san3a/elfany_details/technician_profile_screen.dart';
import 'package:san3a/elfany_details/technicians_list_screen.dart';
import '../features/onboarding/presentation/screens/app_shared.dart';
import '../features/onboarding/presentation/screens/bottom_nav.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<String> _categories = const [
    'سباكة',
    'كهرباء',
    'تكييف',
    'دهانات',
    'نجارة',
  ];
  final List<String> _recentSearches = const [
    'سباكة',
    'كهرباء',
    'تنظيف',
    'تكييف',
  ];
  final List<ServiceResult> _allResults = const [
    ServiceResult(title: 'إصلاح حنفية', count: '120', category: 'سباكة'),
    ServiceResult(title: 'تغيير مفتاح كهرباء', count: '98', category: 'كهرباء'),
    ServiceResult(title: 'غسيل سيارة', count: '87', category: 'تنظيف'),
    ServiceResult(title: 'صباغة غرفة', count: '76', category: 'دهانات'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _query = widget.initialQuery!;
      _searchController.text = widget.initialQuery!;
    }
  }

  List<String> get _filteredCategories {
    if (_query.isEmpty) return _categories;
    return _categories.where((c) => c.contains(_query)).toList();
  }

  List<ServiceResult> get _filteredResults {
    return buildSearchResults(_query, kTechnicians, kServices);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToResults({String? query, String? category}) {
    final value = (query ?? category ?? _searchController.text).trim();
    if (value.isEmpty) return;

    setState(() {
      _query = value;
      _searchController.text = value;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top White Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'ابحث عن خدمة',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search Bar — بقى TextField فعلي بيفلتر لحظة بلحظة
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF3F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Color(0xFF94A3B8),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.search,
                              onChanged: (value) =>
                                  setState(() => _query = value.trim()),
                              onSubmitted: (value) {
                                if (value.trim().isEmpty) return;
                                _goToResults(query: value.trim());
                              },
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                isCollapsed: true,
                                border: InputBorder.none,
                                hintText: 'ابحث عن فني أو خدمة...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          if (_query.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFF94A3B8),
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Horizontal Category Chips
                  if (_filteredCategories.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          for (final category in _filteredCategories) ...[
                            CategoryChip(
                              label: category,
                              onTap: () => _goToResults(category: category),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  // قسم "عمليات البحث الأخيرة" بيختفي وإنت بتكتب
                  if (_query.isEmpty) ...[
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'عمليات البحث الأخيرة',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      children: [
                        for (final label in _recentSearches)
                          RecentSearchChip(
                            label: label,
                            onTap: () => _goToResults(query: label),
                          ),
                      ],
                    ),
                    const SizedBox(height: 28),
                  ],

                  // Most Searched Title — بيتغير لـ "نتائج البحث" وإنت بتكتب
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _query.isEmpty
                          ? 'الأكثر بحثاً'
                          : 'نتائج مطابقة لـ "$_query"',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (_filteredResults.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'لا توجد نتائج مطابقة',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                      ),
                    )
                  else ...[
                    for (int i = 0; i < _filteredResults.length; i++) ...[
                      SearchResultTile(
                        result: _filteredResults[i],
                        onTap: () {
                          final result = _filteredResults[i];
                          if (result.isTechnician) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProviderProfileScreen(
                                  name: result.title,
                                  profession: result.category,
                                  rating: '4.8',
                                  reviewCount: '120',
                                  completedJobs: '1240+ مهمة',
                                  price: '150',
                                  imageUrl: result.imageUrl ?? '',
                                  isAvailable: true,
                                ),
                              ),
                            );
                          } else {
                            _goToResults(query: result.title);
                          }
                        },
                      ),
                      if (i != _filteredResults.length - 1)
                        const Divider(color: Color(0xFFE2E8F0), thickness: 0.8),
                    ],
                  ],

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar — shared widget, same one used across the app
      bottomNavigationBar: const BottomNav(activeLabel: 'بحث'),
    );
  }
}

// Category Chip — دلوقتي بياخد onTap
class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const CategoryChip({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}

// Recent Search Chip — دلوقتي بياخد onTap
class RecentSearchChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const RecentSearchChip({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.access_time, size: 14, color: Color(0xFF94A3B8)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceResult {
  final String title;
  final String count;
  final String category;
  final bool isTechnician;
  final String? imageUrl;

  const ServiceResult({
    required this.title,
    required this.count,
    required this.category,
    this.isTechnician = false,
    this.imageUrl,
  });
}

List<ServiceResult> buildSearchResults(
  String query,
  List<Technician> technicians,
  List<ServiceCategory> services,
) {
  final normalizedQuery = query.trim().toLowerCase();
  final results = <ServiceResult>[];

  if (normalizedQuery.isEmpty) {
    return results;
  }

  final matchedServices = services.where((service) {
    return service.label.toLowerCase().contains(normalizedQuery) ||
        service.key.toLowerCase().contains(normalizedQuery);
  });

  for (final service in matchedServices) {
    results.add(
      ServiceResult(title: service.label, count: '120', category: service.key),
    );
  }

  final matchedTechnicians = technicians.where((technician) {
    return technician.name.toLowerCase().contains(normalizedQuery) ||
        technician.category.toLowerCase().contains(normalizedQuery);
  });

  for (final technician in matchedTechnicians) {
    results.add(
      ServiceResult(
        title: technician.name.trim(),
        count: technician.reviews,
        category: technician.category,
        isTechnician: true,
        imageUrl: technician.photo,
      ),
    );
  }

  return results;
}

class SearchResultTile extends StatelessWidget {
  final ServiceResult result;
  final VoidCallback? onTap;

  const SearchResultTile({super.key, required this.result, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    result.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  color: Color(0xFFF97316),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  result.count,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
