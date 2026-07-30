import 'package:flutter/material.dart';
import 'bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFF3F5F9),
        useMaterial3: true,
      ),
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool instantNotifications = true;
  bool nightMode = false;
  bool locationServices = true;
  bool fingerprintLogin = false;
  bool sounds = true;

  int currentNavIndex = -1;

  static const Color activeBlue = Color(0xFF1565F5);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF8A8F98);
  static const Color dangerRed = Color(0xFFE0392B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F5F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            color: textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              _sectionLabel('التفضيلات'),
              const SizedBox(height: 8),
              _card(
                children: [
                  _switchTile(
                    label: 'الإشعارات الفورية',
                    value: instantNotifications,
                    onChanged: (v) => setState(() => instantNotifications = v),
                  ),
                  _divider(),
                  _switchTile(
                    label: 'الوضع الليلي',
                    value: nightMode,
                    onChanged: (v) => setState(() => nightMode = v),
                  ),
                  _divider(),
                  _switchTile(
                    label: 'خدمات الموقع',
                    value: locationServices,
                    onChanged: (v) => setState(() => locationServices = v),
                  ),
                  _divider(),
                  _switchTile(
                    label: 'تسجيل الدخول بالبصمة',
                    value: fingerprintLogin,
                    onChanged: (v) => setState(() => fingerprintLogin = v),
                  ),
                  _divider(),
                  _switchTile(
                    label: 'الأصوات',
                    value: sounds,
                    onChanged: (v) => setState(() => sounds = v),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _sectionLabel('الحساب'),
              const SizedBox(height: 8),
              _card(
                children: [
                  _navTile(label: 'تغيير كلمة المرور', onTap: () {}),
                  _divider(),
                  _navTile(label: 'اللغة (العربية)', onTap: () {}),
                  _divider(),
                  _deleteAccountTile(onTap: () {}),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    'صنعة  ·  v2.0.0  ·  جميع الحقوق محفوظة © 2025',
                    style: TextStyle(color: textGray, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(activeLabel: 'حسابي'),
    );
  }

  // --- Section label ---
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: textGray,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // --- Card container ---
  Widget _card({required List<Widget> children}) {
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
      child: Column(children: children),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF0F1F4));
  }

  // --- Toggle row ---
  Widget _switchTile({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.9,
            child: Switch.adaptive(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: activeBlue,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFD8DCE3),
            ),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: textDark,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Navigation row with chevron ---
  Widget _navTile({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            const Icon(Icons.chevron_left, color: textGray, size: 20),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Delete account row (red) ---
  Widget _deleteAccountTile({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          'حذف الحساب',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: dangerRed,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // --- Bottom navigation bar ---
}
