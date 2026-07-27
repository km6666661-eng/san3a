import 'package:flutter/material.dart';
import 'package:san3a/elfany_details/booking_details_screen.dart';

class ProviderProfileScreen extends StatefulWidget {
  final String name;
  final String profession;
  final String rating; // e.g. '4.9'
  final String reviewCount; // e.g. '١٣٤٢'
  final String completedJobs; // e.g. '+1240'
  final String yearsExperience; // مش جاي من سكرين النتائج، فسبته Default
  final String price; // '150'
  final String imageUrl;
  final bool isAvailable;

  const ProviderProfileScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.rating,
    required this.reviewCount,
    required this.completedJobs,
    this.yearsExperience = '8',
    required this.price,
    required this.imageUrl,
    this.isAvailable = true,
  });

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  int _selectedTabIndex = 0; // 0: نبذة, 1: التقييمات, 2: الأعمال

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: Column(
        children: [
          // 1. Header Section
          Container(
            color: const Color(0xFF1553D6),
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 12,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                // Navigation Bar Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favorite Icon
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    // Back Arrow
                    InkWell(
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Avatar with Online Badge
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(widget.imageUrl),
                      ),
                    ),
                    if (widget.isAvailable)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),

                // Name & Verified Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),

                // Profession
                Text(
                  widget.profession,
                  style: const TextStyle(
                    color: Color(0xFFBFDBFE),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),

                // Stars Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFF97316),
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.rating} (${widget.reviewCount})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Stats Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatItem(value: widget.completedJobs, label: 'مهمة'),
                    StatItem(value: widget.yearsExperience, label: 'سنوات'),
                    StatItem(value: widget.rating, label: 'تقييم'),
                  ],
                ),
              ],
            ),
          ),

          // 2. Custom Tab Bar (نبذة - التقييمات - الأعمال)
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTabItem(title: 'نبذة', index: 0),
                _buildTabItem(title: 'التقييمات', index: 1),
                _buildTabItem(title: 'الأعمال', index: 2),
              ],
            ),
          ),

          // 3. Main Content View Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildTabContent(),
            ),
          ),

          // 4. Fixed Bottom Action Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Book Now Primary Button -> بيودّي على BookingScreen بنفس بيانات الفني
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingScreen(
                              technicianName: widget.name,
                              profession: widget.profession,
                              rating: widget.rating,
                              price: widget.price,
                              imageUrl: widget.imageUrl,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1553D6),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'احجز الآن — ${widget.price} ج/ساعة',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Call Action Button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF22C55E)),
                    ),
                    child: const Icon(
                      Icons.phone_outlined,
                      color: Color(0xFF16A34A),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Chat Action Button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3FE),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF1553D6)),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Color(0xFF1553D6),
                      size: 20,
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

  // Helper Widget for Tab Items
  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFF1553D6)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected
                  ? const Color(0xFF1553D6)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  // Render Content based on current selected Tab Index
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildAboutTab();
      case 1:
        return _buildReviewsTab();
      case 2:
        return _buildPortfolioTab();
      default:
        return _buildAboutTab();
    }
  }

  // --- Tab 1: نبذة ---
  // (المحتوى الوصفي هنا لسه ثابت لأنه مش جاي من سكرين النتائج)
  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'خبير سباكة محترف بخبرة 8 سنوات في إصلاح الأعطال،\nتركيب الأدوات الصحية، وإصلاح تسريبات المياه.',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13.5,
              color: Color(0xFF475569),
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Skills Header & Chips
        const Text(
          'المهارات والشهادات',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            SkillChip(label: 'إصلاح الأنابيب'),
            SkillChip(label: 'سخانات المياه'),
            SkillChip(label: 'تسريبات'),
            SkillChip(label: 'صيانة عامة'),
            SkillChip(label: 'تركيب بانيو'),
            SkillChip(label: 'معتمد'),
          ],
        ),
        const SizedBox(height: 20),

        // Service Details Section
        const Text(
          'تفاصيل الخدمة',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const DetailRow(
                icon: Icons.access_time_rounded,
                title: 'وقت الاستجابة',
                value: 'خلال 30 دقيقة',
              ),
              const Divider(height: 20, color: Color(0xFFF1F5F9)),
              const DetailRow(
                icon: Icons.location_on_outlined,
                title: 'منطقة الخدمة',
                value: 'القاهرة والجيزة',
              ),
              const Divider(height: 20, color: Color(0xFFF1F5F9)),
              const DetailRow(
                icon: Icons.shield_outlined,
                title: 'الضمان',
                value: '90 يوم',
              ),
              const Divider(height: 20, color: Color(0xFFF1F5F9)),
              DetailRow(
                icon: Icons.credit_card_outlined,
                title: 'السعر ابتداءً',
                value: '${widget.price} ج/ساعة',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Tab 2: التقييمات ---
  Widget _buildReviewsTab() {
    return Column(
      children: [
        // Overall Rating Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Rating Big Score
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.rating,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF97316),
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.reviewCount} تقييم',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Rating Breakdown Bars
              Expanded(
                child: Column(
                  children: const [
                    RatingBarItem(starNumber: 5, percentage: 0.85),
                    RatingBarItem(starNumber: 4, percentage: 0.12),
                    RatingBarItem(starNumber: 3, percentage: 0.03),
                    RatingBarItem(starNumber: 2, percentage: 0.01),
                    RatingBarItem(starNumber: 1, percentage: 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Reviews List
        const ReviewItemCard(
          name: 'سارة أحمد',
          date: '15 يناير',
          avatarText: 'س',
          avatarBgColor: Color(0xFF1D61E7),
          ratingCount: 5,
          ratingText: '5.0',
          comment: 'عمل ممتاز! محترف جداً وملتزم بالمواعيد.',
        ),
        const SizedBox(height: 10),

        const ReviewItemCard(
          name: 'خالد مصطفى',
          date: '10 يناير',
          avatarText: 'خ',
          avatarBgColor: Color(0xFF0284C7),
          ratingCount: 5,
          ratingText: '5.0',
          comment: 'أصلح التسريب بسرعة وكفاءة. أنصح به بشدة.',
        ),
        const SizedBox(height: 10),

        const ReviewItemCard(
          name: 'نورا إبراهيم',
          date: '28 ديسمبر',
          avatarText: 'ن',
          avatarBgColor: Color(0xFF2563EB),
          ratingCount: 4,
          ratingText: '4.0',
          comment: 'جيد بشكل عام. تأخر قليلاً لكن جودة العمل ممتازة.',
        ),
      ],
    );
  }

  // --- Tab 3: الأعمال ---
  Widget _buildPortfolioTab() {
    final List<String> galleryImages = [
      'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=300',
      'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=300',
      'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=300',
      'https://images.unsplash.com/photo-1581092335397-9583fe92d232?w=300',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: galleryImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            galleryImages[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFFCBD5E1),
              child: const Icon(Icons.image, color: Colors.white, size: 40),
            ),
          ),
        );
      },
    );
  }
}

// Stats Sub-Widget
class StatItem extends StatelessWidget {
  final String value;
  final String label;

  const StatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFBFDBFE), fontSize: 11),
        ),
      ],
    );
  }
}

// Skill Chip Widget
class SkillChip extends StatelessWidget {
  final String label;

  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1553D6),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Detail Row Widget
class DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFEBF3FE),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF1553D6), size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

// Rating Breakdown Bar
class RatingBarItem extends StatelessWidget {
  final int starNumber;
  final double percentage;

  const RatingBarItem({
    super.key,
    required this.starNumber,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$starNumber',
            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFF97316),
                ),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Review Item Card
class ReviewItemCard extends StatelessWidget {
  final String name;
  final String date;
  final String avatarText;
  final Color avatarBgColor;
  final int ratingCount;
  final String ratingText;
  final String comment;

  const ReviewItemCard({
    super.key,
    required this.name,
    required this.date,
    required this.avatarText,
    required this.avatarBgColor,
    required this.ratingCount,
    required this.ratingText,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: avatarBgColor,
                child: Text(
                  avatarText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    ratingText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Row(
                    children: List.generate(
                      ratingCount,
                      (index) => const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF97316),
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
