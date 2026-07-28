import 'package:flutter/material.dart';
import 'package:san3a/features/onboarding/presentation/screens/app_shared.dart';
import 'package:san3a/thefanypov/service_request_data.dart';

// ============================================================
// LOCAL COLOR PALETTE (no external AppColors dependency)
// ============================================================
const Color kBlue1 = Color(0xFF3A6FF7);
const Color kCard = Colors.white;
const Color kBg = Color(0xFFF6F7FB);
const Color kTextDark = Color(0xFF1E2432);
const Color kTextMid = Color(0xFF5B6472);
const Color kTextMute = Color(0xFF9AA3B2);
const Color kGold = Color(0xFFFFB800);
const Color kGreen = Color(0xFF1FAE64);

class ServiceRequestCard extends StatelessWidget {
  final ServiceRequest request;
  const ServiceRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final r = request;
    return GestureDetector(
      onTap: () => goTo(context, 'طلب: ${r.title}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // badge + avatar row
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        r.photo,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                          width: 44,
                          height: 44,
                          color: kBg,
                          child: const Icon(
                            Icons.person,
                            color: kTextMute,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: r.tierColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          r.tierLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: r.urgency.bg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    r.urgency.label,
                    style: TextStyle(
                      color: r.urgency.fg,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              r.title,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: kTextDark,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${r.priceRange} ج',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: kGreen,
                  ),
                ),
                const SizedBox(width: 6),
                const Text('·', style: TextStyle(color: kTextMute)),
                const SizedBox(width: 6),
                Text(
                  r.location,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: kTextMute,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.location_on_outlined,
                  size: 13,
                  color: kTextMute,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${r.rating}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kGold,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.star, size: 13, color: kGold),
                const SizedBox(width: 6),
                Text(
                  r.providerName,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                  ),
                ),
                const Spacer(),
                Text(
                  '${r.offersCount} عروض',
                  style: const TextStyle(
                    fontSize: 12,
                    color: kTextMute,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              r.description,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.5,
                color: kTextMid,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => goTo(context, 'تقديم عرض: ${r.title}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue1,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'تقديم عرض',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.send, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}