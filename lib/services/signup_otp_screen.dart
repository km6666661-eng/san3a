import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class SignUpOtpScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String nationalId;

  const SignUpOtpScreen({
    Key? key,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.nationalId,
  }) : super(key: key);

  @override
  State<SignUpOtpScreen> createState() => _SignUpOtpScreenState();
}

class _SignUpOtpScreenState extends State<SignUpOtpScreen> {
  final _codeController = TextEditingController();
  String? _codeError;
  bool _isSendingCode = true;
  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _sendCode();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    setState(() {
      _isSendingCode = true;
      _codeError = null;
    });

    final authService = context.read<AuthService>();
    await authService.sendPhoneVerificationCode(
      phoneNumber: widget.phoneNumber,
      onCodeSent: () {
        if (!mounted) return;
        setState(() => _isSendingCode = false);
      },
      onFailed: (error) {
        if (!mounted) return;
        setState(() {
          _isSendingCode = false;
          _codeError = error;
        });
      },
    );
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.length != 6) {
      setState(() => _codeError = 'الرجاء إدخال الكود المكوّن من 6 أرقام');
      return;
    }

    setState(() {
      _isVerifying = true;
      _codeError = null;
    });

    final authService = context.read<AuthService>();
    final firestoreService = context.read<FirestoreService>();

    try {
      await authService.confirmOtpAndLinkPhone(code);

      final uid = authService.currentUser?.uid;
      if (uid != null) {
        await firestoreService.saveUserProfile(
          uid: uid,
          fullName: widget.fullName,
          email: widget.email,
          phone: widget.phoneNumber,
          nationalId: widget.nationalId,
        );
      }

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.home,
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
        _codeError = authService.errorMessage ?? 'كود غير صحيح. حاول مرة أخرى.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FE),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                'تأكيد رقم الهاتف',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 8),
              Text(
                'تم إرسال كود التفعيل إلى ${widget.phoneNumber}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 24),
              if (_isSendingCode)
                const Center(child: CircularProgressIndicator())
              else ...[
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  style: const TextStyle(fontSize: 20, letterSpacing: 8),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '000000',
                    errorText: _codeError,
                    filled: true,
                    fillColor: const Color(0xFFF4F6F9),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1557D0), width: 1.5)),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1557D0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isVerifying ? null : _verifyCode,
                    child: _isVerifying
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('تأكيد', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: _isResending
                        ? null
                        : () async {
                            setState(() => _isResending = true);
                            await _sendCode();
                            if (mounted) setState(() => _isResending = false);
                          },
                    child: const Text('إعادة إرسال الكود', style: TextStyle(color: Color(0xFF1557D0), fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
