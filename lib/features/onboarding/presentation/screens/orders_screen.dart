import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import 'bottom_nav.dart';

enum OrderStatus { completed, ongoing, cancelled }

class OrderItem {
  final String service;
  final String orderNumber;
  final String date;
  final String customerName;
  final String customerInitial;
  final Color avatarColor;
  final int price;
  final double? rating;
  final OrderStatus status;

  OrderItem({
    required this.service,
    required this.orderNumber,
    required this.date,
    required this.customerName,
    required this.customerInitial,
    required this.avatarColor,
    required this.price,
    this.rating,
    required this.status,
  });
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  static const Color activeBlue = Color(0xFF1565F5);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF8A8F98);
  static const Color completedGreenBg = Color(0xFFDFF5E6);
  static const Color completedGreenText = Color(0xFF1FA855);
  static const Color ongoingBlueBg = Color(0xFFE3ECFF);
  static const Color cancelledRedBg = Color(0xFFFBDCE0);
  static const Color cancelledRedText = Color(0xFFE0392B);
  static const Color starOrange = Color(0xFFFF9F1C);

  String selectedFilter = 'الكل';

  final List<OrderItem> orders = [
    OrderItem(
      service: 'سباكة',
      orderNumber: '#2401',
      date: '2025 يناير 15',
      customerName: 'أحمد حسن',
      customerInitial: 'أ',
      avatarColor: const Color(0xFF1565F5),
      price: 350,
      rating: 5.0,
      status: OrderStatus.completed,
    ),
    OrderItem(
      service: 'كهرباء',
      orderNumber: '#2389',
      date: '2025 يناير 10',
      customerName: 'محمد علي',
      customerInitial: 'م',
      avatarColor: const Color(0xFF1565F5),
      price: 420,
      rating: 4.0,
      status: OrderStatus.completed,
    ),
    OrderItem(
      service: 'تكييف',
      orderNumber: '#2402',
      date: '2025 يناير 20',
      customerName: 'خالد عمر',
      customerInitial: 'خ',
      avatarColor: const Color(0xFF1565F5),
      price: 600,
      rating: null,
      status: OrderStatus.ongoing,
    ),
    OrderItem(
      service: 'دهانات',
      orderNumber: '#2377',
      date: '2025 يناير 5',
      customerName: 'سارة يوسف',
      customerInitial: 'س',
      avatarColor: const Color(0xFF1565F5),
      price: 480,
      rating: null,
      status: OrderStatus.cancelled,
    ),
  ];

  List<OrderItem> get filteredOrders {
    switch (selectedFilter) {
      case 'مكتملة':
        return orders.where((o) => o.status == OrderStatus.completed).toList();
      case 'جارية':
        return orders.where((o) => o.status == OrderStatus.ongoing).toList();
      case 'ملغاة':
        return orders.where((o) => o.status == OrderStatus.cancelled).toList();
      default:
        return orders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F5F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: textDark,
          title: const Text(
            'طلباتي',
            style: TextStyle(
              color: textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              _filterBar(),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) =>
                      _orderCard(filteredOrders[index]),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNav(activeLabel: 'طلباتي'),
      ),
    );
  }

  // --- Filter chip bar ---
  Widget _filterBar() {
    final filters = ['الكل', 'مكتملة', 'جارية', 'ملغاة'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: filters.map((f) => _filterChip(f)).toList(),
      ),
    );
  }

  Widget _filterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeBlue : const Color(0xFFD8DCE3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : textDark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // --- Order card ---
  Widget _orderCard(OrderItem order) {
    return Container(
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.service,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '${order.date} · ${order.orderNumber}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: textGray, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                _statusBadge(order.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                const SizedBox(width: 8),
                Text(
                  order.customerName,
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF0F1F4)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    '${order.price} ج',
                    style: const TextStyle(
                      color: textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (order.status == OrderStatus.ongoing) ...[
                      _pillButton('تتبع', filled: true),
                      const SizedBox(width: 8),
                    ],
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profile),
                      child: _pillButton('تفاصيل', filled: false),
                    ),
                  ],
                ),
              ],
            ),
            if (order.rating != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  children: [
                    Text(
                      order.rating!.toStringAsFixed(1),
                      style: const TextStyle(color: textGray, fontSize: 12),
                    ),
                    const SizedBox(width: 6),
                    ...List.generate(5, (i) {
                      final filled = i < order.rating!.floor();
                      return Icon(
                        filled ? Icons.star : Icons.star_border,
                        color: starOrange,
                        size: 16,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _pillButton(String label, {required bool filled}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? activeBlue.withOpacity(0.1) : const Color(0xFFF0F1F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? activeBlue : textDark,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statusBadge(OrderStatus status) {
    late String label;
    late Color bg;
    late Color fg;
    switch (status) {
      case OrderStatus.completed:
        label = 'مكتمل';
        bg = completedGreenBg;
        fg = completedGreenText;
        break;
      case OrderStatus.ongoing:
        label = 'جار';
        bg = ongoingBlueBg;
        fg = activeBlue;
        break;
      case OrderStatus.cancelled:
        label = 'ملغي';
        bg = cancelledRedBg;
        fg = cancelledRedText;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
