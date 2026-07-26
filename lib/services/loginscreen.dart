import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/routes/app_routes.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // متغيرات لتخزين رسائل الخطأ لكل حقل
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    // إعادة تعيين الأخطاء قبل البدء
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    bool hasError = false;

    // 1. التحقق المحلي (Local Validation)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      _emailError = 'الرجاء إدخال البريد الإلكتروني';
      hasError = true;
    } else if (!emailRegex.hasMatch(email)) {
      _emailError = 'صيغة البريد الإلكتروني غير صحيحة';
      hasError = true;
    }

    if (password.isEmpty) {
      _passwordError = 'الرجاء إدخال كلمة المرور';
      hasError = true;
    } else if (password.length < 6) {
      _passwordError = 'كلمة المرور يجب ألا تقل عن 6 أحرف';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    // 2. الاتصال بـ Firebase عبر الـ AuthService
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signIn(
        email: email,
        password: password,
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);

    } catch (e) {
      if (!mounted) return;
      
      // جلب رسالة الخطأ القادمة من AuthException
      String errorMsg = authService.errorMessage ?? e.toString();
      
      setState(() {
        if (errorMsg.contains('لا يوجد حساب') || errorMsg.contains('user-not-found')) {
          _emailError = errorMsg;
        } else if (errorMsg.contains('غير صحيحة') || errorMsg.contains('wrong-password') || errorMsg.contains('invalid-credential')) {
          _passwordError = errorMsg;
        } else if (errorMsg.contains('البريد الإلكتروني غير صالح')) {
          _emailError = errorMsg;
        } else {
          _emailError = errorMsg;
        }
      });
    } finally {
      // لضمان إيقاف حالة التحميل وتحديث الشاشة في جميع الأحوال (نجاح أو فشل)
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // الهيدر الأزرق
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1557D0),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'مرحباً بعودتك!',
                        style: TextStyle(fontFamily: 'ElMessiri',
                          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'سجل دخولك للمتابعة',
                        style: TextStyle(fontFamily: 'ElMessiri',
                          color: Colors.white.withOpacity(0.85), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // محتوى الشاشة
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('البريد الإلكتروني', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        if (_emailError != null) setState(() => _emailError = null);
                      },
                      decoration: InputDecoration(
                        hintText: 'you@email.com',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: Icon(Icons.person, color: Colors.grey.shade400),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        errorText: _emailError,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1557D0), width: 1.5)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textAlign: TextAlign.right,
                      onChanged: (value) {
                        if (_passwordError != null) setState(() => _passwordError = null);
                      },
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey.shade400, size: 20),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        prefixIcon: Icon(Icons.lock_rounded, color: Colors.grey.shade400),
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        errorText: _passwordError,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1557D0), width: 1.5)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                        onPressed: () {},
                        child: const Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(color: Color(0xFF1557D0), fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // زر تسجيل الدخول
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1557D0).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1557D0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: authService.isLoading ? null : () => _login(context),
                        child: authService.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Text('تسجيل الدخول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('أو تابع مع', style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.apple, color: Colors.black, size: 20),
                            label: const Text('Apple', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.g_mobiledata, color: Colors.blue, size: 28),
                            label: const Text('Google', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ليس لديك حساب؟ ', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.signUp);
                            },
                            child: const Text(
                              'أنشئ حساباً',
                              style: TextStyle(color: Color(0xFF1557D0), fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
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