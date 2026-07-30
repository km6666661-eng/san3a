import 'package:flutter/material.dart';
import 'package:san3a/elfany_details/technician_profile_screen.dart';
import 'app_shared.dart';

class ServicesPage extends StatelessWidget {
  final String? initialCategory;

  const ServicesPage({super.key, this.initialCategory});

  List<Technician> get filteredTechnicians {
    if (initialCategory == null || initialCategory!.isEmpty) {
      return kTechnicians;
    }
    return kTechnicians.where((t) => t.category == initialCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final technicians = filteredTechnicians;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(initialCategory == null ? 'كل الخدمات' : initialCategory!),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        titleTextStyle: const TextStyle(
          color: AppColors.textDark,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Column(
        children: [
          if (initialCategory != null) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.blue1.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.blue1),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'تم عرض الفنيين المتعلقين بالخدمة: $initialCategory',
                      style: const TextStyle(
                        color: AppColors.blue1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: technicians.isEmpty
                ? const Center(
                    child: Text(
                      'لا يوجد فنيين متاحين لهذه الخدمة حالياً',
                      style: TextStyle(color: AppColors.textMute, fontSize: 14),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: technicians.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final technician = technicians[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProviderProfileScreen(
                                name: technician.name.trim(),
                                profession: technician.category,
                                rating: technician.rating.toStringAsFixed(1),
                                reviewCount: technician.reviews.replaceAll(
                                  RegExp(r'[()\s]'),
                                  '',
                                ),
                                completedJobs: '1240+ مهمة',
                                price: technician.price.toString(),
                                imageUrl: technician.photo,
                                isAvailable: true,
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
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(technician.photo),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      technician.name.trim(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      technician.category,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMute,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: AppColors.gold,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${technician.rating} ${technician.reviews}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textMid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${technician.price} ج',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.blue1,
                                    ),
                                  ),
                                  const Text(
                                    '/ ساعة',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMute,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
