import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import 'app_shared.dart';
import 'bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum OrderStatus { completed, pending, cancelled }

class OrderItem {
  final String service;
  final String orderNumber;
  final String date;
  final String customerName;
  final String customerInitial;
  final Color avatarColor;
  final double price;
  final double rating;
  final OrderStatus status;

  OrderItem({
    required this.service,
    required this.orderNumber,
    required this.date,
    required this.customerName,
    required this.customerInitial,
    required this.avatarColor,
    required this.price,
    required this.rating,
    required this.status,
  });
}

class SavedAddress {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDefault;

  SavedAddress({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDefault = false,
  });
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool isEditing = false;
  bool _isLoading = true;

  String fullName = 'أسم المستخدم';
  String email = 'user@example.com';
  String phone = '+20 000 000 0000';
  String location = 'غير محدد';
  String joinDate = 'غير معروف';
  String accountType = 'عميل';
  String nationalId = 'غير متوفر';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final authService = context.read<AuthService>();
    final firestoreService = context.read<FirestoreService>();
    final uid = authService.currentUser?.uid;

    if (uid == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final profile = await firestoreService.getUserProfile(uid);
    if (profile != null) {
      setState(() {
        fullName = profile.fullName.isNotEmpty ? profile.fullName : fullName;
        email = profile.email.isNotEmpty ? profile.email : email;
        phone = profile.phone.isNotEmpty ? profile.phone : phone;
        nationalId = profile.nationalId.isNotEmpty
            ? profile.nationalId
            : nationalId;
        accountType = profile.accountType == 'technician' ? 'فني' : 'عميل';
        joinDate = profile.createdAt != null
            ? '${profile.createdAt!.day}/${profile.createdAt!.month}/${profile.createdAt!.year}'
            : joinDate;
        _isLoading = false;
      });
      return;
    }

    if (authService.currentUser != null) {
      setState(() {
        fullName = authService.currentUser?.displayName ?? fullName;
        email = authService.currentUser?.email ?? email;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  final List<SavedAddress> addresses = [
    SavedAddress(
      title: 'المنزل',
      subtitle: 'شارع النصر، مدينة نصر، القاهرة',
      icon: Icons.home_outlined,
      isDefault: true,
    ),
    SavedAddress(
      title: 'العمل',
      subtitle: 'شارع التحرير، وسط البلد، القاهرة',
      icon: Icons.apartment_outlined,
    ),
  ];

  final List<OrderItem> previewOrders = [
    OrderItem(
      service: 'سباكة',
      orderNumber: '#2401',
      date: '15 يناير 2025',
      customerName: 'أحمد حسن',
      customerInitial: 'أ',
      avatarColor: AppColors.blue1,
      price: 350,
      rating: 5.0,
      status: OrderStatus.completed,
    ),
    OrderItem(
      service: 'كهرباء',
      orderNumber: '#2389',
      date: '10 يناير 2025',
      customerName: 'محمد علي',
      customerInitial: 'م',
      avatarColor: AppColors.blue2,
      price: 420,
      rating: 4.0,
      status: OrderStatus.completed,
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(child: _header()),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PinnedHeaderDelegate(child: _tabBar()),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [_overviewTab(), _ordersTab(), _savedTab()],
              ),
            ),
      bottomNavigationBar: const BottomNav(activeLabel: 'حسابي'),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.blue2, AppColors.blue1],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(top: -20, right: -30, child: _bubble(90)),
          Positioned(top: 60, left: -20, child: _bubble(60)),
          Positioned(top: 10, left: 80, child: _bubble(40)),
          Column(
            children: [
              Row(
                children: [
                  _iconCircleButton(Icons.notifications_none, hasDot: true),
                  const Spacer(),
                  _editButton(),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.orange2, width: 3),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B7CF6), Color(0xFF1E4FD6)],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      fullName.isNotEmpty ? fullName[0] : '؟',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.orange2,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              isEditing
                  ? _editableUnderlineField(
                      fullName,
                      (v) => fullName = v,
                      center: true,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.green,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          fullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 4),
              isEditing
                  ? _editableUnderlineField(
                      email,
                      (v) => email = v,
                      center: true,
                      muted: true,
                    )
                  : Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
              if (!isEditing) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statChip(Icons.thumb_up_alt_outlined, '4.8', 'تقييمي'),
                    _statChip(Icons.favorite_border, '7', 'مفضلة'),
                    _statChip(Icons.star_border, '18', 'تقييم'),
                    _statChip(Icons.description_outlined, '24', 'حجز'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bubble(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.06),
      ),
    );
  }

  Widget _iconCircleButton(IconData icon, {bool hasDot = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        if (hasDot)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.orange2,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _editButton() {
    return GestureDetector(
      onTap: () => setState(() => isEditing = !isEditing),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isEditing
              ? AppColors.orange2
              : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isEditing ? Icons.save_outlined : Icons.edit_outlined,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 6),
            Text(
              isEditing ? 'حفظ التغييرات' : 'تعديل الملف',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editableUnderlineField(
    String initial,
    ValueChanged<String> onChanged, {
    bool center = false,
    bool muted = false,
  }) {
    return SizedBox(
      width: 220,
      child: TextFormField(
        initialValue: initial,
        onChanged: onChanged,
        textAlign: center ? TextAlign.center : TextAlign.right,
        style: TextStyle(
          color: muted ? Colors.white70 : Colors.white,
          fontSize: muted ? 13 : 18,
          fontWeight: muted ? FontWeight.normal : FontWeight.bold,
        ),
        decoration: const InputDecoration(
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.blue1,
        unselectedLabelColor: AppColors.textMute,
        indicatorColor: AppColors.blue1,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'نظرة عامة'),
          Tab(text: 'طلباتي'),
          Tab(text: 'المحفوظات'),
        ],
      ),
    );
  }

  Widget _overviewTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'المعلومات الشخصية',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => isEditing = !isEditing),
              child: Row(
                children: const [
                  Icon(Icons.edit_outlined, color: AppColors.blue1, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'تعديل',
                    style: TextStyle(
                      color: AppColors.blue1,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _infoCard(),
        const SizedBox(height: 24),
        _quickLinks(),
        const SizedBox(height: 20),
        _logoutButton(),
      ],
    );
  }

  Widget _infoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _infoTile(
            Icons.person_outline,
            'الاسم الكامل',
            fullName,
            editable: isEditing,
            onChanged: (v) => fullName = v,
          ),
          _divider(),
          _infoTile(
            Icons.call_outlined,
            'رقم الهاتف',
            phone,
            editable: isEditing,
            onChanged: (v) => phone = v,
            valueDirection: TextDirection.ltr,
          ),
          _divider(),
          _infoTile(
            Icons.email_outlined,
            'البريد الإلكتروني',
            email,
            editable: isEditing,
            onChanged: (v) => email = v,
            valueDirection: TextDirection.ltr,
          ),
          _divider(),
          _infoTile(
            Icons.badge_outlined,
            'نوع الحساب',
            accountType,
            editable: false,
          ),
          _divider(),
          _infoTile(
            Icons.credit_card_outlined,
            'الرقم القومي',
            nationalId,
            editable: false,
          ),
          _divider(),
          _infoTile(
            Icons.calendar_today_outlined,
            'تاريخ الانضمام',
            joinDate,
            editable: false,
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: Color(0xFFF0F1F4));

  Widget _infoTile(
    IconData icon,
    String label,
    String value, {
    bool editable = false,
    ValueChanged<String>? onChanged,
    TextDirection valueDirection = TextDirection.rtl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFEDF2FF),
            child: Icon(icon, color: AppColors.blue1, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textMute,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                editable
                    ? Directionality(
                        textDirection: valueDirection,
                        child: TextFormField(
                          initialValue: value,
                          onChanged: onChanged,
                          textAlign: valueDirection == TextDirection.rtl
                              ? TextAlign.right
                              : TextAlign.left,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.blue1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.blue1),
                            ),
                          ),
                        ),
                      )
                    : Directionality(
                        textDirection: valueDirection,
                        child: Text(
                          value,
                          textAlign: valueDirection == TextDirection.rtl
                              ? TextAlign.right
                              : TextAlign.left,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          editable
              ? const Icon(Icons.edit, color: AppColors.blue1, size: 18)
              : const Icon(
                  Icons.chevron_left,
                  color: AppColors.textMute,
                  size: 20,
                ),
        ],
      ),
    );
  }

  Widget _quickLinks() {
    final links = <List<Map<String, dynamic>>>[
      [
        {
          'icon': Icons.home_outlined,
          'label': 'الرئيسية',
          'color': AppColors.blue1,
        },
        {
          'icon': Icons.receipt_long_outlined,
          'label': 'طلباتي',
          'color': const Color(0xFF2ECC71),
        },
        {
          'icon': Icons.notifications_none,
          'label': 'الإشعارات',
          'color': const Color(0xFFFF9F5A),
        },
      ],
      [
        {
          'icon': Icons.search,
          'label': 'بحث',
          'color': const Color(0xFF29C7D1),
        },
        {
          'icon': Icons.settings_outlined,
          'label': 'الإعدادات',
          'color': AppColors.textMute,
        },
        {
          'icon': Icons.help_outline,
          'label': 'الدعم',
          'color': const Color(0xFF7C5CFC),
        },
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'روابط سريعة',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        for (final row in links) ...[
          Row(
            children: row
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _quickLinkTile(
                        item['icon'] as IconData,
                        item['label'] as String,
                        item['color'] as Color,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _quickLinkTile(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        if (label == 'الإعدادات') {
          Navigator.pushNamed(context, AppRoutes.settings);
        } else if (label == 'الرئيسية') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        } else if (label == 'طلباتي') {
          Navigator.pushNamed(context, AppRoutes.orders);
        } else if (label == 'بحث') {
          Navigator.pushNamed(context, AppRoutes.technicians);
        } else if (label == 'الإشعارات') {
          Navigator.pushNamed(context, AppRoutes.orders);
        } else if (label == 'الدعم') {
          Navigator.pushNamed(context, AppRoutes.settings);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE7E5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout, color: AppColors.orange2, size: 18),
          SizedBox(width: 8),
          Text(
            'تسجيل الخروج',
            style: TextStyle(
              color: AppColors.orange2,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ordersTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final order in previewOrders) ...[
          _miniOrderCard(order),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.orders),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.blue1,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'عرض كل الطلبات المفصلة',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _miniOrderCard(OrderItem order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: order.avatarColor,
            child: Text(
              order.customerInitial,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.service,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${order.date} · ${order.orderNumber}',
                  style: const TextStyle(
                    color: AppColors.textMute,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${order.price} ج.م',
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _savedTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'عناوين محفوظة',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            _addLink(),
          ],
        ),
        const SizedBox(height: 10),
        for (final addr in addresses) ...[
          _addressCard(addr),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'طرق الدفع',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            _addLink(),
          ],
        ),
        const SizedBox(height: 10),
        _paymentCard(),
      ],
    );
  }

  Widget _addLink() {
    return Row(
      children: const [
        Icon(Icons.add, color: AppColors.blue1, size: 16),
        SizedBox(width: 2),
        Text(
          'إضافة',
          style: TextStyle(
            color: AppColors.blue1,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _addressCard(SavedAddress addr) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFF0F1F4),
            child: Icon(addr.icon, color: AppColors.textDark, size: 18),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        addr.title,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (addr.isDefault) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3ECFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'افتراضي',
                            style: TextStyle(
                              color: AppColors.blue1,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    addr.subtitle,
                    style: const TextStyle(
                      color: AppColors.textMute,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _roundIconButton(
            Icons.edit_outlined,
            const Color(0xFFE3ECFF),
            AppColors.blue1,
          ),
          const SizedBox(width: 8),
          _roundIconButton(
            Icons.delete_outline,
            const Color(0xFFFDE7E5),
            AppColors.orange2,
          ),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.blue2,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'VISA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '•••• 7891',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3ECFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'افتراضي',
                          style: TextStyle(
                            color: AppColors.blue1,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'تنتهي 09/27',
                    style: TextStyle(color: AppColors.textMute, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          _roundIconButton(
            Icons.delete_outline,
            const Color(0xFFFDE7E5),
            AppColors.orange2,
          ),
        ],
      ),
    );
  }

  Widget _roundIconButton(IconData icon, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: fg, size: 16),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _PinnedHeaderDelegate({required this.child});

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) => false;
}
