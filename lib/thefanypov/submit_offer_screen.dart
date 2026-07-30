import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:san3a/thefanypov/service_request_data.dart';

class SubmitOfferScreen extends StatefulWidget {
  final ServiceRequest request;
  const SubmitOfferScreen({Key? key, required this.request}) : super(key: key);
  

  @override
  State<SubmitOfferScreen> createState() => _SubmitOfferScreenState();
}

class _SubmitOfferScreenState extends State<SubmitOfferScreen> {
  // State variables for user selections
  final TextEditingController _priceController = TextEditingController(text: '320');
  final TextEditingController _coverLetterController = TextEditingController();
  
  String _selectedCompletionTime = 'اليوم';
  String _selectedWarranty = '90 يوم';
  String _selectedStartDate = 'اليوم';
  
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _priceController.addListener(() {
      setState(() {});
    });
    _coverLetterController.addListener(() {
      setState(() {
        _characterCount = _coverLetterController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _coverLetterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE3EDFC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1967D2), size: 18),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            '',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Banner Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1967D2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'الطلب',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'إصلاح تسريب مياه في الحمام',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'الميزانية: 200-400 ج',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Proposed Price Section
              const Text(
                'سعرك المقترح (ج)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E9F0)),
                ),
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        '\$',
                        style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Completion Time Section
              const Text(
                'وقت الإنجاز',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSelectableChip('اليوم', _selectedCompletionTime, (val) => setState(() => _selectedCompletionTime = val)),
                  _buildSelectableChip('يومان', _selectedCompletionTime, (val) => setState(() => _selectedCompletionTime = val)),
                  _buildSelectableChip('3 أيام', _selectedCompletionTime, (val) => setState(() => _selectedCompletionTime = val)),
                  _buildSelectableChip('أسبوع', _selectedCompletionTime, (val) => setState(() => _selectedCompletionTime = val)),
                ],
              ),
              const SizedBox(height: 20),

              // Warranty Period Section
              const Text(
                'مدة الضمان',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildWarrantyChip('120 يوم'),
                  _buildWarrantyChip('90 يوم'),
                  _buildWarrantyChip('60 يوم'),
                  _buildWarrantyChip('30 يوم'),
                ],
              ),
              const SizedBox(height: 20),

              // Start Date Section
              const Text(
                'تاريخ البدء',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSelectableChip('بعد غد', _selectedStartDate, (val) => setState(() => _selectedStartDate = val)),
                  _buildSelectableChip('الغد', _selectedStartDate, (val) => setState(() => _selectedStartDate = val)),
                  _buildSelectableChip('اليوم', _selectedStartDate, (val) => setState(() => _selectedStartDate = val)),
                ],
              ),
              const SizedBox(height: 20),

              // Cover Letter Section
              const Text(
                'خطاب التقديم',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E9F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _coverLetterController,
                      maxLines: 4,
                      maxLength: 300,
                      decoration: const InputDecoration(
                        hintText: 'عرّف العميل بنفسك، اشرح كيف ستحل مشكلتك، ولماذا أنت الخيار الأفضل...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                        counterText: '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        '$_characterCount/300',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Similar Work Images Section
             // Similar Work Images Section
const Text(
  'صور أعمال مشابهة',
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1A1A1A),
  ),
),
const SizedBox(height: 8),
Wrap(
  spacing: 10,
  runSpacing: 10,
  children: [
    GestureDetector(
      onTap: _pickImage,
      child: DashedContainer(
        color: const Color(0xFF1967D2),
        radius: const Radius.circular(12),
        child: Container(
          width: 70,
          height: 70,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: Color(0xFF1967D2), size: 20),
              SizedBox(height: 2),
              Text(
                'إضافة',
                style: TextStyle(color: Color(0xFF1967D2), fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),
              const SizedBox(height: 20),

              // Offer Summary Receipt Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E9F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ملخص عرضك',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryRow('السعر المقترح', '${_priceController.text} ج'),
                    const SizedBox(height: 8),
                    _buildSummaryRow('وقت الإنجاز', _selectedCompletionTime),
                    const SizedBox(height: 8),
                    _buildSummaryRow('الضمان', _selectedWarranty),
                    const SizedBox(height: 8),
                    _buildSummaryRow('تاريخ البدء', _selectedStartDate),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submit Offer Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.send, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'إرسال العرض',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

Future<void> _pickImage() async {
  if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('رفع الصور غير متاح في هذا الإصدار حاليًا.'),
    ),
  );
}


  Widget _buildSelectableChip(String title, String selectedValue, ValueChanged<String> onSelected) {
    final bool isSelected = title == selectedValue;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelected(title),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1967D2) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF1967D2) : const Color(0xFFE5E9F0),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWarrantyChip(String title) {
    final bool isSelected = title == _selectedWarranty;
    return GestureDetector(
      onTap: () => setState(() => _selectedWarranty = title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF27AE60) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF27AE60) : const Color(0xFFE5E9F0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// Dashed Border Custom Widget Helper
class DashedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double gap;
  final Radius radius;

  const DashedContainer({
    Key? key,
    required this.child,
    this.color = const Color(0xFF1967D2),
    this.strokeWidth = 1.5,
    this.gap = 5.0,
    this.radius = const Radius.circular(12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        radius: radius,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final Radius radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      radius,
    );

    final Path path = Path()..addRRect(rRect);
    
    Path dashPath = Path();
    double distance = 0.5;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}