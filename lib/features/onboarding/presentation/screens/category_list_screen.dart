import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'orders_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
      
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFF3F4F8),
        primaryColor: const Color(0xFF2952E3),
      ),
      home: const CategoryListScreen(),
    );
  }
}

class Electrician {
  final String name;
  final double rating;
  final int reviewsCount;
  final bool isAvailableNow;
  final double distanceKm;
  final int points;
  final int pricePerHour;
  final bool isOnline;
  final String imageUrl;
  final bool verified;

  const Electrician({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.isAvailableNow,
    required this.distanceKm,
    required this.points,
    required this.pricePerHour,
    required this.isOnline,
    required this.imageUrl,
    this.verified = true,
  });
}

class _NavTabData {
  final IconData icon;
  final String label;
  final int? badgeCount;

  const _NavTabData({
    required this.icon,
    required this.label,
    this.badgeCount,
  });
}

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() =>
      _ElectriciansListScreenState();
}

class _ElectriciansListScreenState extends State<CategoryListScreen> {
  int selectedFilterIndex = 3;

  int selectedTabIndex = -1;

  final List<String> filters = ['التعليقات', 'المسافة', 'السعر', 'التقييم'];

  final List<Electrician> electricians = const [
    Electrician(
      name: 'أحمد حسن',
      rating: 4.9,
      reviewsCount: 342,
      isAvailableNow: true,
      distanceKm: 1.2,
      points: 1240,
      pricePerHour: 150,
      isOnline: true,
      imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    ),
    Electrician(
      name: 'محمد علي',
      rating: 4.8,
      reviewsCount: 218,
      isAvailableNow: true,
      distanceKm: 0.8,
      points: 890,
      pricePerHour: 180,
      isOnline: true,
      imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
    ),
    Electrician(
      name: 'خالد عمر',
      rating: 4.7,
      reviewsCount: 195,
      isAvailableNow: false,
      distanceKm: 2.1,
      points: 720,
      pricePerHour: 220,
      isOnline: false,
      imageUrl: 'https://randomuser.me/api/portraits/men/54.jpg',
    ),
    Electrician(
      name: 'يوسف إبراهيم',
      rating: 4.6,
      reviewsCount: 150,
      isAvailableNow: true,
      distanceKm: 1.6,
      points: 610,
      pricePerHour: 160,
      isOnline: true,
      imageUrl: 'https://randomuser.me/api/portraits/men/61.jpg',
    ),
    Electrician(
      name: 'عمر سامي',
      rating: 4.5,
      reviewsCount: 98,
      isAvailableNow: true,
      distanceKm: 2.7,
      points: 430,
      pricePerHour: 140,
      isOnline: true,
      imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildFiltersRow(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${electricians.length} فني متاح قريب منك',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: electricians.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: ElectricianCard(electrician: electricians[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
     
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  
  void _onNavTabTap(int index) {
    switch (index) {
      case 2: // طلباتي
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrdersScreen()),
        );
        break;
      case 4: 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      default:
        setState(() => selectedTabIndex = index);
    }
  }

  Widget _buildBottomNavBar() {
    final tabs = [
      _NavTabData(icon: Icons.home_outlined, label: 'الرئيسية'),
      _NavTabData(icon: Icons.search, label: 'بحث'),
      _NavTabData(icon: Icons.description_outlined, label: 'طلباتي'),
      _NavTabData(
          icon: Icons.notifications_outlined,
          label: 'إشعارات',
          badgeCount: 3),
      _NavTabData(icon: Icons.person_outline, label: 'حسابي'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (index) {
                final bool isSelected = index == selectedTabIndex;
                final Color color =
                    isSelected ? const Color(0xFF2952E3) : Colors.black54;
                return Expanded(
                  child: InkWell(
                    onTap: () => _onNavTabTap(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(tabs[index].icon, size: 24, color: color),
                            if (tabs[index].badgeCount != null)
                              Positioned(
                                top: -4,
                                right: -8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE53935),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
                                  ),
                                  constraints: const BoxConstraints(
                                      minWidth: 18, minHeight: 18),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${tabs[index].badgeCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tabs[index].label,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            _circleIconButton(
              Icons.tune,
              () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            const Spacer(),
            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: const Color(0xFF14141C),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                'فنيين الكهرباء',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            _circleIconButton(
              Icons.arrow_back,
              () => Navigator.maybePop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildFiltersRow() {
  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: List.generate(filters.length, (index) {
            final bool isSelected = index == selectedFilterIndex;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => setState(() => selectedFilterIndex = index),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF2952E3) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2952E3)
                            : const Color(0xFFE3E5EC),
                      ),
                    ),
                    child: Text(
                      filters[index],
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ElectricianCard extends StatelessWidget {
  final Electrician electrician;

  const ElectricianCard({super.key, required this.electrician});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEDE3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Color(0xFFFF7A45),
                  ),
                ),
                const SizedBox(width: 12),
                // الاسم والمهنة والتقييم
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (electrician.verified) ...[
                                const Icon(
                                  Icons.shield_outlined,
                                  size: 16,
                                  color: Color(0xFF2952E3),
                                ),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                electrician.name,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'كهرباء',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              '${electrician.rating} (${electrician.reviewsCount})',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 4),
                            ...List.generate(
                              5,
                              (i) => Icon(
                                i < electrician.rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 14,
                                color: const Color(0xFFFFA534),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // صورة الشخص
                ClipOval(
                  child: Image.network(
                    electrician.imageUrl,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 52,
                      height: 52,
                      color: const Color(0xFFE3E5EC),
                      child: const Icon(Icons.person, color: Colors.black38),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                Text(
                  electrician.isAvailableNow ? 'متاح الآن' : 'مشغول',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: electrician.isAvailableNow
                        ? const Color(0xFF1FAE5A)
                        : Colors.black45,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.emoji_events,
                    size: 14, color: Color(0xFFFFA534)),
                const SizedBox(width: 2),
                Text(
                  '${electrician.points}+ مهمة',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.location_on_outlined,
                    size: 14, color: Colors.black45),
                const SizedBox(width: 2),
                Text(
                  '${electrician.distanceKm} كم',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
       
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
              
                SizedBox(
                  width: 100,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: electrician.isAvailableNow
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const OrdersScreen(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2952E3),
                      disabledBackgroundColor: const Color(0xFFD7D9E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'احجز',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
               
                Text(
                  '${electrician.pricePerHour} ج/ساعة',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: electrician.isOnline
                        ? const Color(0xFF1FAE5A)
                        : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




