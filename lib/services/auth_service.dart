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

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _run(() async {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        throw AuthException('الرجاء إدخال البريد الإلكتروني وكلمة المرور');
      }
      if (password.length < 6) {
        throw AuthException('كلمة المرور يجب ألا تقل عن 6 أحرف');
      }
      _user = AuthUser(
        uid: 'local-user-${DateTime.now().millisecondsSinceEpoch}',
        email: email.trim(),
        displayName: displayName?.trim(),
      );
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    await _run(() async {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        throw AuthException('الرجاء إدخال البريد الإلكتروني وكلمة المرور');
      }
      if (password.length < 6) {
        throw AuthException('كلمة المرور يجب ألا تقل عن 6 أحرف');
      }
      _user = AuthUser(
        uid: 'local-user-${DateTime.now().millisecondsSinceEpoch}',
        email: email.trim(),
      );
    });
  }

  Future<void> signOut() async {
    await _run(() async {
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
    } catch (e) {
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
}
