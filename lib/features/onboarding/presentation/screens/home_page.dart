import 'package:flutter/material.dart';
import 'package:san3a/elfany_details/search_screen.dart';

import '../../../../core/routes/app_routes.dart';
import 'app_shared.dart';
import 'bottom_nav.dart';
import 'services_page.dart';
import 'offers_page.dart';
import 'technicians_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory; // null = "all"

  List<Technician> get filteredTechnicians {
    if (selectedCategory == null) return kTechnicians;
    return kTechnicians.where((t) => t.category == selectedCategory).toList();
  }

  void onFilterTap(String categoryKey) {
    setState(() {
      selectedCategory = selectedCategory == categoryKey ? null : categoryKey;
    });
    goTo(context, selectedCategory == null ? 'كل الخدمات' : selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(),
              _PromoBanner(),
              const SizedBox(height: 8),
              _ServicesSection(
                selectedCategory: selectedCategory,
                onTap: onFilterTap,
              ),
              const SizedBox(height: 8),
              _OffersSection(),
              const SizedBox(height: 8),
              _TechniciansSection(technicians: filteredTechnicians),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createRequest),
        backgroundColor: AppColors.blue1,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'طلب خدمة',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );
  }
}

// ============================================================
// HEADER
// ============================================================
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.blue1, AppColors.blue2],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _CircleIconButton(
                child: const Text(
                  'ج',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'صباح الخير',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'ابرام انور 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _CircleIconButton(
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                showDot: true,
                onTap: () => Navigator.pushNamed(context, AppRoutes.orders),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => goTo(context, 'اختيار الموقع'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'القاهرة، مدينة نصر، شارع النصر',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withOpacity(0.9),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.location_on,
                  color: Colors.white.withOpacity(0.9),
                  size: 15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.16),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.85),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ابحث عن خدمة أو فني...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool showDot;
  const _CircleIconButton({
    required this.child,
    required this.onTap,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: child,
          ),
          if (showDot)
            Positioned(
              top: 4,
              left: 6,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4757),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.blue1, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// PROMO BANNER
// ============================================================
class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: GestureDetector(
        onTap: () => goTo(context, 'عرض الخصم المحدود'),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.orange1, AppColors.orange2],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.orange2.withOpacity(0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.build_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'عرض محدود',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'خصم 25%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'على أول خدمة تحجزها',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.createRequest,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'احجز الآن',
                          style: TextStyle(
                            color: AppColors.orange2,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION HEADER (shared)
// ============================================================
class _SectionHeader extends StatelessWidget {
  final String title;
  final String linkLabel;
  final VoidCallback onLinkTap;
  final bool titleOnRight;
  const _SectionHeader({
    required this.title,
    required this.linkLabel,
    required this.onLinkTap,
    this.titleOnRight = true,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      ),
    );
    final linkWidget = GestureDetector(
      onTap: onLinkTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!titleOnRight) ...[
            const Icon(Icons.chevron_left, size: 16, color: AppColors.blue1),
          ],
          Text(
            linkLabel,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.blue1,
            ),
          ),
          if (titleOnRight) ...[
            const SizedBox(width: 2),
            const Icon(Icons.chevron_left, size: 16, color: AppColors.blue1),
          ],
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: titleOnRight
            ? [linkWidget, titleWidget]
            : [linkWidget, titleWidget],
      ),
    );
  }
}

// ============================================================
// SERVICES / FILTERS SECTION
// ============================================================
class _ServicesSection extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String> onTap;
  const _ServicesSection({required this.selectedCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        _SectionHeader(
          title: 'الخدمات',
          linkLabel: 'عرض الكل',
          onLinkTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ServicesPage()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 4,
            childAspectRatio: 0.78,
            children: kServices.map((s) {
              final isActive = selectedCategory == s.key;
              return GestureDetector(
                onTap: () => onTap(s.key),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: s.bg,
                        borderRadius: BorderRadius.circular(18),
                        border: isActive
                            ? Border.all(color: AppColors.blue1, width: 2.5)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Icon(s.icon, color: s.fg, size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: isActive
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isActive ? AppColors.blue1 : AppColors.textMid,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// OFFERS SECTION
// ============================================================
class _OffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        _SectionHeader(
          title: 'أبرز العروض',
          linkLabel: 'عرض الكل',
          onLinkTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OffersPage()),
          ),
        ),
        SizedBox(
          height: 168,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: kOffers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final o = kOffers[i];
              return GestureDetector(
                onTap: () => goTo(context, 'عرض: ${o.title}'),
                child: Container(
                  width: 168,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: Image.network(
                              o.image,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  height: 100,
                                  color: AppColors.bg,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stack) =>
                                  Container(
                                    height: 100,
                                    color: AppColors.bg,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: AppColors.textMute,
                                    ),
                                  ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.orange2,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                o.discount,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o.title,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              o.category,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMute,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
 //editing this section rn
class _TechniciansSection extends StatelessWidget {
  final List<Technician> technicians;
  const _TechniciansSection({required this.technicians});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        _SectionHeader(
          title: 'أفضل الفنيين',
          linkLabel: 'الكل',
          onLinkTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TechniciansPage()),
          ),
          titleOnRight: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: technicians.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Text(
                      'لا يوجد فنيين متاحين في هذا التصنيف حاليًا',
                      style: TextStyle(color: AppColors.textMute, fontSize: 13),
                    ),
                  ),
                )
              : Column(
                  children: technicians
                      .map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _TechnicianCard(technician: t),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }
}

class _TechnicianCard extends StatelessWidget {
  final Technician technician;
  const _TechnicianCard({required this.technician});

  @override
  Widget build(BuildContext context) {
    final t = technician;
    return GestureDetector(
      onTap: () => goTo(context, 'فني: ${t.name}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    t.photo,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      width: 56,
                      height: 56,
                      color: AppColors.bg,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.textMute,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  left: -2,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    t.name,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMute,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        t.distance,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textMid,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '·',
                        style: TextStyle(color: AppColors.textMid),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        t.reviews,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textMid,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${t.rating}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.gold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.star, size: 12, color: AppColors.gold),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${t.price} ج',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.blue1,
                  ),
                ),
                const Text(
                  '/ ساعة',
                  style: TextStyle(fontSize: 10.5, color: AppColors.textMute),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}