import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'signup_otp_screen.dart';

class SignUpStepTwoScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String nationalId;
  final File? criminalRecordImage; // استقبال صورة الفيش والتشبيه

  const SignUpStepTwoScreen({
    Key? key,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.nationalId,
    this.criminalRecordImage, // جعله اختيارياً ليناسب العميل والفني معاَ
  }) : super(key: key);

  @override
  State<SignUpStepTwoScreen> createState() => _SignUpStepTwoScreenState();
}

class _SignUpStepTwoScreenState extends State<SignUpStepTwoScreen> {
  final _passwordController = TextEditingController();
  bool _isChecked = true;
  bool _obscurePassword = true;

  String? _passwordError;
  String? _termsError;
  int _passwordStrength = 0;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;
    int strength = 0;

    if (password.length >= 6) strength++;
    if (password.contains(RegExp(r'[A-Z]')) || password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _completeSignUp(BuildContext context) async {
    setState(() {
      _passwordError = null;
      _termsError = null;
    });

    final password = _passwordController.text.trim();
    bool hasError = false;

    if (password.isEmpty) {
      _passwordError = 'الرجاء إدخال كلمة المرور';
      hasError = true;
    } else if (password.length < 6) {
      _passwordError = 'كلمة المرور يجب ألا تقل عن 6 أحرف';
      hasError = true;
    }

    if (!_isChecked) {
      _termsError = 'يجب الموافقة على شروط الاستخدام وسياسة الخصوصية';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUp(
        email: widget.email,
        password: password,
        displayName: widget.fullName,
      );

      // الحساب اتعمل بنجاح، دلوقتي هنبعت كود تفعيل لرقم الهاتف
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpOtpScreen(
            fullName: widget.fullName,
            email: widget.email,
            phoneNumber: widget.phoneNumber,
            nationalId: widget.nationalId,
            // لو شاشة الـ OTP محتاجة الصورة كمان، تقدر تمررها هنا:
            // criminalRecordImage: widget.criminalRecordImage,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authService.errorMessage ?? 'حدث خطأ في إنشاء الحساب')),
      );
    }
  }

  Color _getStrengthColor() {
    if (_passwordStrength == 1) return Colors.red;
    if (_passwordStrength == 2) return Colors.orange;
    if (_passwordStrength >= 3) return Colors.green;
    return Colors.grey.shade300;
  }

  String _getStrengthText() {
    if (_passwordStrength == 1) return 'ضعيفة';
    if (_passwordStrength == 2) return 'متوسطة';
    if (_passwordStrength >= 3) return 'قوية';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FE),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const SizedBox.shrink(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3EDFC),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF1557D0), size: 16),
                    constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFF1557D0), borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 8),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFF1557D0), borderRadius: BorderRadius.circular(2)))),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text('الخطوة 2 من 2', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 24),

              const Text('كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textAlign: TextAlign.right,
                onChanged: (value) {
                  if (_passwordError != null && value.trim().length >= 6) {
                    setState(() => _passwordError = null);
                  }
                },
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  prefixIcon: Icon(Icons.lock_rounded, color: Colors.grey.shade400, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey.shade400, size: 20),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF4F6F9),
                  errorText: _passwordError,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1557D0), width: 1.5)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
                ),
              ),
              const SizedBox(height: 8),

              if (_passwordController.text.isNotEmpty) ...[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: _passwordStrength >= 1 ? _getStrengthColor() : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: _passwordStrength >= 2 ? _getStrengthColor() : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: _passwordStrength >= 3 ? _getStrengthColor() : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _getStrengthText(),
                      style: TextStyle(color: _getStrengthColor(), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF1FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _isChecked,
                        activeColor: const Color(0xFF1557D0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        side: BorderSide(color: Colors.grey.shade400),
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value ?? false;
                            if (_isChecked) _termsError = null;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'أوافق على شروط الاستخدام وسياسة الخصوصية',
                        style: TextStyle(color: Color(0xFF1557D0), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              if (_termsError != null) ...[
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    _termsError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ],
              const SizedBox(height: 32),

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
                  onPressed: authService.isLoading ? null : () => _completeSignUp(context),
                  child: authService.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('إنشاء الحساب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
