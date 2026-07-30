// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthUser {
  final String uid;
  final String email;
  final String? displayName;

  const AuthUser({required this.uid, required this.email, this.displayName});
}

class AuthService extends ChangeNotifier {
  late final FirebaseAuth _firebaseAuth;
  AuthUser? _user;
  bool _isLoading = false;
  bool _authReady = true;
  String? _errorMessage;
  String? _verificationId;

  AuthUser? get currentUser => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  bool get authReady => _authReady;
  String? get errorMessage => _errorMessage;

  AuthService() {
    try {
      _firebaseAuth = FirebaseAuth.instance;
      _firebaseAuth.authStateChanges().listen((user) {
        if (user == null) {
          _user = null;
        } else {
          _user = AuthUser(
            uid: user.uid,
            email: user.email ?? '',
            displayName: user.displayName,
          );
        }
        _authReady = true;
        notifyListeners();
      });
    } catch (e) {
      _authReady = false;
      _errorMessage = 'تعذر تهيئة المصادقة. تأكد من إعداد Firebase.';
      // Do not rethrow so provider creation doesn't fail; consumers can
      // check `authReady` and `errorMessage` to show proper UI.
      // ignore: avoid_print
      print('AuthService initialization error: $e');
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _run(() async {
      final normalizedEmail = email.trim();
      final normalizedPassword = password.trim();

      if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
        throw AuthException('الرجاء إدخال البريد الإلكتروني وكلمة المرور');
      }
      if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(normalizedEmail)) {
        throw AuthException('صيغة البريد الإلكتروني غير صحيحة');
      }
      if (normalizedPassword.length < 6) {
        throw AuthException('كلمة المرور يجب ألا تقل عن 6 أحرف');
      }

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: normalizedPassword,
      );

      if (displayName != null && displayName.trim().isNotEmpty) {
        await credential.user?.updateDisplayName(displayName.trim());
      }

      _user = AuthUser(
        uid: credential.user?.uid ?? '',
        email: credential.user?.email ?? normalizedEmail,
        displayName: credential.user?.displayName ?? displayName?.trim(),
      );
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    await _run(() async {
      final normalizedEmail = email.trim();
      final normalizedPassword = password.trim();

      if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
        throw AuthException('الرجاء إدخال البريد الإلكتروني وكلمة المرور');
      }
      if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(normalizedEmail)) {
        throw AuthException('صيغة البريد الإلكتروني غير صحيحة');
      }
      if (normalizedPassword.length < 6) {
        throw AuthException('كلمة المرور يجب ألا تقل عن 6 أحرف');
      }

      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: normalizedPassword,
      );

      _user = AuthUser(
        uid: credential.user?.uid ?? '',
        email: credential.user?.email ?? normalizedEmail,
        displayName: credential.user?.displayName,
      );
    });
  }

  Future<void> signOut() async {
    await _run(() async {
      await _firebaseAuth.signOut();
      _user = null;
    });
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> sendPhoneVerificationCode({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onFailed,
  }) async {
    try {
      await _run(() async {
        _verificationId = 'mock-verification-id';
        onCodeSent();
      });
    } catch (_) {
      onFailed('تعذر إرسال كود التفعيل. حاول مرة أخرى.');
    }
  }

  Future<void> confirmOtpAndLinkPhone(String smsCode) async {
    await _run(() async {
      if (_verificationId == null) {
        throw AuthException('حدث خطأ في التحقق. حاول إرسال الكود مرة أخرى.');
      }
      if (smsCode.trim().length != 6) {
        throw AuthException('الرجاء إدخال الكود المكوّن من 6 أرقام');
      }
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await action();
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapFirebaseError(e);
      throw AuthException(_errorMessage!);
    } catch (e) {
      _errorMessage = e is AuthException
          ? e.message
          : 'حدث خطأ ما. حاول مرة أخرى.';
      throw AuthException(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح.';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب.';
      case 'user-not-found':
        return 'لا يوجد حساب بهذا البريد الإلكتروني.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً (6 أحرف على الأقل).';
      case 'invalid-verification-code':
        return 'الكود غير صحيح. تأكد من الكود وحاول مرة أخرى.';
      case 'invalid-verification-id':
      case 'session-expired':
        return 'انتهت صلاحية الكود. اطلب كوداً جديداً.';
      case 'credential-already-in-use':
        return 'رقم الهاتف مستخدم بالفعل في حساب آخر.';
      default:
        return e.message ?? 'فشلت العملية.';
    }
  }
}
