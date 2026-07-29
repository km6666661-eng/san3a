import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// شاشة الدعم الفني - نسخة احترافية وشغّالة فعلاً
/// بتستخدم باكدج url_launcher عشان تفتح مكالمة / إيميل / واتساب
class TechSupportScreen extends StatelessWidget {
  const TechSupportScreen({Key? key}) : super(key: key);

  // ====== بيانات التواصل - غيّريها بالبيانات الحقيقية بتاعتك ======
  static const String _phoneNumber = '+201211892733';
  static const String _supportEmail = 'San3a@gmail.com';
  static const String _whatsappNumber = '201126588499'; // من غير + أو أصفار زيادة
  static const String _whatsappGroupLink = 'https://chat.whatsapp.com/HE3A9my93BQ7l7CWLUCchY?s=cl&p=a&ilr=0';

  static const Color _primaryBlue = Color(0xFF1557D0);
  static const Color _darkBlue = Color(0xFF0E3E9E);
  static const Color _lightBlueBg = Color(0xFFE8F0FE);
  static const Color _pageBg = Color(0xFFF5F7FA);

  // ====== دوال فتح الروابط ======

  Future<void> _launch(BuildContext context, Uri uri) async {
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح التطبيق المطلوب، تأكد من تثبيته')),
      );
    }
  }

  void _callPhone(BuildContext context) {
    _launch(context, Uri(scheme: 'tel', path: _phoneNumber));
  }

  void _sendEmail(BuildContext context) {
    _launch(
      context,
      Uri(
        scheme: 'mailto',
        path: _supportEmail,
        query: 'subject=طلب دعم فني&body=مرحباً، أحتاج مساعدة في...',
      ),
    );
  }

  void _openWhatsAppChat(BuildContext context) {
    _launch(
      context,
      Uri.parse('https://wa.me/$_whatsappNumber?text=مرحباً، أحتاج مساعدة'),
    );
  }

  void _openWhatsAppGroup(BuildContext context) {
    _launch(context, Uri.parse(_whatsappGroupLink));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _pageBg,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildHeader(context),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _SupportCard(
                    icon: Icons.phone_in_talk_rounded,
                    iconColor: _primaryBlue,
                    iconBg: _lightBlueBg,
                    title: 'الاتصال الهاتفي',
                    subtitle: 'للمكالمات المباشرة مع فريقنا',
                    detail: _phoneNumber,
                    buttonText: 'اتصل الآن',
                    buttonColor: _primaryBlue,
                    onPressed: () => _callPhone(context),
                  ),
                  const SizedBox(height: 16),
                  _SupportCard(
                    icon: Icons.email_rounded,
                    iconColor: const Color(0xFF7B4FE0),
                    iconBg: const Color(0xFFF0EAFC),
                    title: 'البريد الإلكتروني',
                    subtitle: 'للأسئلة والاستشارات العامة',
                    detail: _supportEmail,
                    buttonText: 'أرسل بريد',
                    buttonColor: const Color(0xFF7B4FE0),
                    onPressed: () => _sendEmail(context),
                  ),
                  const SizedBox(height: 16),
                  _SupportCard(
                    icon: Icons.chat_rounded,
                    iconColor: const Color(0xFF25D366),
                    iconBg: const Color(0xFFE7F9EF),
                    title: 'محادثة واتساب مباشرة',
                    subtitle: 'احصل على دعم سريع',
                    detail: '+$_whatsappNumber',
                    buttonText: 'ابدأ المحادثة',
                    buttonColor: const Color(0xFF25D366),
                    onPressed: () => _openWhatsAppChat(context),
                  ),
                  const SizedBox(height: 16),
                  _SupportCard(
                    icon: Icons.groups_rounded,
                    iconColor: const Color(0xFF25D366),
                    iconBg: const Color(0xFFE7F9EF),
                    title: 'مجتمع واتساب',
                    subtitle: 'انضم للمجموعة وتابع التحديثات',
                    detail: 'تحديثات وتواصل مفيد',
                    buttonText: 'انضم الآن',
                    buttonColor: const Color(0xFF25D366),
                    onPressed: () => _openWhatsAppGroup(context),
                  ),
                  const SizedBox(height: 28),
                  _buildFooter(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// الهيدر الأزرق المموّج مع نمط زخرفي خفيف بالخلفية
  SliverAppBar _buildHeader(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _primaryBlue,
      elevation: 0,
      expandedHeight: 190,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipPath(
          clipper: _HeaderWaveClipper(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_primaryBlue, _darkBlue],
              ),
            ),
            child: Stack(
              children: [
                // نمط الموجات الزخرفي الخفيف في الخلفية
                Positioned.fill(
                  child: CustomPaint(painter: _DecorativeWavePainter()),
                ),
                // المحتوى: العنوان + الوصف + الخط الفاصل الصغير
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'الدعم الفني',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'تواصل معنا، نحن هنا لمساعدتك',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: 46,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      leading: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 14, top: 6),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: _primaryBlue, size: 15),
                constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user_rounded, size: 15, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(
          'نهتم بخصوصيتك ونسعى لتقديم أفضل خدمة لك',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

/// شكل الموجة أسفل الهيدر (الانتقال الناعم للون الخلفية)
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 42);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 18,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 42,
      size.width,
      size.height - 10,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// نمط موجات زخرفي شفاف خلف العنوان، بنفس روح الصورة المرجعية
class _DecorativeWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.15);
    path1.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.35,
      size.width * 0.65,
      size.height * 0.1,
    );
    path1.quadraticBezierTo(
      size.width * 0.85,
      size.height * -0.05,
      size.width,
      size.height * 0.1,
    );
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    path1.close();
    canvas.drawPath(path1, paint);

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.5);
    path2.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.3,
      size.width * 0.55,
      size.height * 0.55,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.75,
      size.width,
      size.height * 0.45,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// كارت واحد لكل وسيلة تواصل - تصميم أنظف وأكثر احترافية
class _SupportCard extends StatelessWidget {
  const _SupportCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String detail;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEFF1F5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1D29),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              detail,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}