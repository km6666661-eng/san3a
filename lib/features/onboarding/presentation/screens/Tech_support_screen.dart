import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// شاشة الدعم الفني - نسخة احترافية وشغّالة فعلاً
/// بتستخدم باكدج url_launcher عشان تفتح مكالمة / إيميل / واتساب
class TechSupportScreen extends StatelessWidget {
  const TechSupportScreen({Key? key}) : super(key: key);

  // ====== بيانات التواصل - غيّريها بالبيانات الحقيقية بتاعتك ======
  static const String _phoneNumber = '+201126588499';
  static const String _supportEmail = 'San3a@gmail.com';
  static const String _whatsappNumber = '+201211892733'; // من غير + أو أصفار زيادة
  static const String _whatsappGroupLink = 'https://chat.whatsapp.com/HE3A9my93BQ7l7CWLUCchY?s=cl&p=a&ilr=0';

  static const Color _primaryBlue = Color(0xFF1557D0);
  static const Color _lightBlueBg = Color(0xFFE8F0FE);

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
        backgroundColor: const Color(0xFFF5F7FA),
        body: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const Text(
                    'تواصل معنا، نحن هنا لمساعدتك',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                    iconColor: _primaryBlue,
                    iconBg: _lightBlueBg,
                    title: 'البريد الإلكتروني',
                    subtitle: 'للأسئلة والاستشارات العامة',
                    detail: _supportEmail,
                    buttonText: 'أرسل بريد',
                    buttonColor: _primaryBlue,
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
                    buttonText: 'ابدأ محادثة',
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
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildHeader(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _primaryBlue,
      elevation: 0,
      expandedHeight: 110,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 16),
        centerTitle: true,
        title: const Text(
          'الدعم الفني',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1557D0), Color(0xFF0E3E9E)],
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(right: 12, top: 8),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: _lightBlueBg,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: _primaryBlue, size: 16),
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    );
  }
}

/// كارت واحد لكل وسيلة تواصل
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
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