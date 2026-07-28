import 'package:flutter/material.dart';
import 'package:san3a/thefanypov/service_request_data.dart';
import 'service_request_card.dart';

// ============================================================
// LOCAL COLOR PALETTE (no external AppColors dependency)
// ============================================================
const Color kBlue1 = Color(0xFF3A6FF7);
const Color kBg = Color(0xFFF6F7FB);
const Color kCard = Colors.white;
const Color kTextDark = Color(0xFF1E2432);
const Color kTextMid = Color(0xFF5B6472);
const Color kTextMute = Color(0xFF9AA3B2);

// ============================================================
// FULL SCREEN: SERVICE REQUESTS
// Pushed on top of another screen (e.g. from Home's "عرض الكل").
// Has a working category filter bar (الكل / سباكة / كهرباء / ...)
// that filters the request cards shown below it.
// ============================================================
class ServiceRequestsPage extends StatefulWidget {
  const ServiceRequestsPage({super.key});

  @override
  State<ServiceRequestsPage> createState() => _ServiceRequestsPageState();
}

class _ServiceRequestsPageState extends State<ServiceRequestsPage> {
  String activeFilter = 'all';

  List<ServiceRequest> get filteredRequests {
    if (activeFilter == 'all') return kServiceRequests;
    return kServiceRequests.where((r) => r.category == activeFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TopBar(),
            const SizedBox(height: 6),
            RequestFilterBar(
              activeFilter: activeFilter,
              onSelect: (key) => setState(() => activeFilter = key),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: filteredRequests.isEmpty
                  ? const Center(
                      child: Text(
                        'لا يوجد طلبات في هذا التصنيف حاليًا',
                        style: TextStyle(color: kTextMute, fontSize: 13),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: filteredRequests.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, i) =>
                          ServiceRequestCard(request: filteredRequests[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TOP BAR
// ============================================================
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward, color: kTextDark),
          ),
          const SizedBox(width: 4),
          const Text(
            'طلبات الخدمة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: kTextDark,
            ),
          ),
          const Spacer(),
          Icon(Icons.tune, color: kTextMute.withOpacity(0.8)),
        ],
      ),
    );
  }
}

// ============================================================
// FILTER BAR (الكل / سباكة / كهرباء / تكييف / دهانات / نجارة)
// Public so the home-page preview section can reuse the exact
// same chip row and stay visually/behaviorally in sync.
// ============================================================
class RequestFilterBar extends StatelessWidget {
  final String activeFilter;
  final ValueChanged<String> onSelect;
  const RequestFilterBar({
    super.key,
    required this.activeFilter,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: kRequestFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = kRequestFilters[i];
          final isActive = activeFilter == f.key;
          return GestureDetector(
            onTap: () => onSelect(f.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: isActive ? kBlue1 : kCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? kBlue1 : kTextMute.withOpacity(0.25),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                f.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isActive ? Colors.white : kTextMid,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}