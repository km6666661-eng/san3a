import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/routes/app_routes.dart';
import '../services/firestore_service.dart';

class ElFanyScreen extends StatefulWidget {
  const ElFanyScreen({Key? key}) : super(key: key);

  @override
  State<ElFanyScreen> createState() => _ElFanyScreenState();
}

class _ElFanyScreenState extends State<ElFanyScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalIdController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _nationalIdError;
  String? _imageError;

  File? _criminalRecordImage; // متغير لتخزين صورة الفيش والتشبيه
  bool _isChecking = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    setState(() {
      _criminalRecordImage = null;
      _imageError = null;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('رفع الصورة غير متاح في هذا الإصدار، يمكنك المتابعة بدون صورة.'),
      ),
    );
  }

  Future<void> _goToNextStep() async {
    setState(() {
      _nameError = null;
      _emailError = null;
      _phoneError = null;
      _nationalIdError = null;
      _imageError = null;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final nationalId = _nationalIdController.text.trim();

    bool hasError = false;

    if (name.isEmpty) {
      _nameError = 'الرجاء إدخال الاسم الكامل';
      hasError = true;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      _emailError = 'الرجاء إدخال البريد الإلكتروني';
      hasError = true;
    } else if (!emailRegex.hasMatch(email)) {
      _emailError = 'صيغة البريد الإلكتروني غير صحيحة';
      hasError = true;
    }

    if (phone.isEmpty) {
      _phoneError = 'الرجاء إدخال رقم الهاتف';
      hasError = true;
    } else if (phone.length != 11 || !RegExp(r'^01[0125][0-9]{8}$').hasMatch(phone)) {
      _phoneError = 'رقم الهاتف يجب أن يكون 11 رقماً ويبدأ بـ 010 أو 011 أو 012 أو 015';
      hasError = true;
    }

    if (nationalId.isEmpty) {
      _nationalIdError = 'الرجاء إدخال الرقم القومي';
      hasError = true;
    } else if (nationalId.length != 14 || int.tryParse(nationalId) == null) {
      _nationalIdError = 'الرقم القومي يجب أن يكون 14 رقماً صحيحاً';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _isChecking = true);

    try {
      final firestoreService = context.read<FirestoreService>();

      final phoneTaken = await firestoreService.isPhoneTaken(phone);
      final nationalIdTaken = await firestoreService.isNationalIdTaken(nationalId);

      if (phoneTaken || nationalIdTaken) {
        setState(() {
          _isChecking = false;
          if (phoneTaken) {
            _phoneError = 'رقم الهاتف مستخدم بالفعل';
          }
          if (nationalIdTaken) {
            _nationalIdError = 'الرقم القومي مستخدم بالفعل';
          }
        });
        return;
      }

      if (!mounted) return;
      setState(() => _isChecking = false);

      // الانتقال للخطوة الثانية مع تمرير البيانات بالإضافة إلى صورة الفيش والتشبيه
      Navigator.pushNamed(
        context,
        AppRoutes.signUpStepTwo,
        arguments: SignUpFlowArgs(
          fullName: name,
          email: email,
          phoneNumber: phone,
          nationalId: nationalId,
          criminalRecordImagePath: _criminalRecordImage?.path,
        ),
      );
    } catch (e) {
      debugPrint('Firestore check error: $e');

      if (!mounted) return;
      setState(() => _isChecking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ أثناء التحقق من البيانات. تأكد من الاتصال بالإنترنت وحاول مرة أخرى.'),
        ),
      );
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
          automaticallyImplyLeading: false,
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
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2)))),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text('الخطوة 1 من 2 (تسجيل فني)', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 24),

              const Text('الاسم الكامل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.right,
                onChanged: (value) {
                  if (_nameError != null && value.trim().isNotEmpty) {
                    setState(() => _nameError = null);
                  }
                },
                decoration: _inputDecoration('أحمد محمد', Icons.person, _nameError),
              ),
              const SizedBox(height: 16),

              const Text('البريد الإلكتروني', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.right,
                onChanged: (value) {
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (_emailError != null && emailRegex.hasMatch(value.trim())) {
                    setState(() => _emailError = null);
                  }
                },
                decoration: _inputDecoration('you@email.com', Icons.email_rounded, _emailError),
              ),
              const SizedBox(height: 16),

              const Text('رقم الهاتف', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.right,
                maxLength: 11,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                onChanged: (value) {
                  if (_phoneError != null && value.trim().length == 11) {
                    setState(() => _phoneError = null);
                  }
                },
                decoration: _inputDecoration('01012345678', Icons.phone, _phoneError).copyWith(counterText: ''),
              ),
              const SizedBox(height: 16),

              const Text('الرقم القومي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 8),
              TextField(
                controller: _nationalIdController,
                keyboardType: TextInputType.number,
                maxLength: 14,
                textAlign: TextAlign.right,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14),
                ],
                onChanged: (value) {
                  if (_nationalIdError != null && value.trim().length == 14) {
                    setState(() => _nationalIdError = null);
                  }
                },
                decoration: _inputDecoration('أدخل الرقم القومي (14 رقم)', Icons.badge_rounded, _nationalIdError),
              ),
              const SizedBox(height: 16),

              // حقل رفع الفيش والتشبيه
              const Text('صورة الفيش والتشبيه (صحيفة الحالة الجنائية)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _imageError != null ? Colors.red : Colors.grey.shade300,
                      width: _imageError != null ? 1.5 : 1,
                    ),
                  ),
                  child: _criminalRecordImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(_criminalRecordImage!, fit: BoxFit.cover),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
                                  child: const Text('اضغط لتغيير الصورة', style: TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cloud_upload_outlined, color: Color(0xFF1557D0), size: 32),
                            const SizedBox(height: 8),
                            const Text('اضغط هنا لرفع صورة الفيش والتشبيه', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                ),
              ),
              if (_imageError != null) ...[
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(_imageError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                ),
              ],
              const SizedBox(height: 24),

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
                  onPressed: _isChecking ? null : _goToNextStep,
                  child: _isChecking
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('التالي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon, String? errorText) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.grey.shade400),
      filled: true,
      fillColor: const Color(0xFFF4F6F9),
      counterText: '',
      errorText: errorText,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1557D0), width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
    );
  }
}