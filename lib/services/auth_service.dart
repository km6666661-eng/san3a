import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      _authReady = true; // fires once we know the real starting auth state
      notifyListeners();
    });
  }

  User? _user;
  bool _isLoading = false;
  bool _authReady = false; // true once the first authStateChanges event arrives
  String? _errorMessage;
  String? _verificationId;

  User? get currentUser => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  bool get authReady => _authReady;
  String? get errorMessage => _errorMessage;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _run(() async {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (displayName != null && displayName.isNotEmpty) {
        await credential.user?.updateDisplayName(displayName);
        await credential.user?.reload();
        _user = _firebaseAuth.currentUser;
      }
    });
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _run(() async {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    });
  }

  Future<void> signOut() async {
    await _run(() async {
      await _firebaseAuth.signOut();
    });
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Formats an Egyptian mobile number like "01012345678" into the
  /// international format Firebase expects, "+201012345678".
  String _toInternationalFormat(String phone) {
    if (phone.startsWith('+')) return phone;
    return '+20${phone.substring(1)}';
  }

  /// Sends an SMS verification code to [phoneNumber]. Call this after the
  /// account already exists (right after signUp), then use
  /// [confirmOtpAndLinkPhone] once the user enters the code.
  Future<void> sendPhoneVerificationCode({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onFailed,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: _toInternationalFormat(phoneNumber),
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          // Android-only instant auto-verification. We don't auto-link
          // here to keep one single code path (manual code entry) for
          // simplicity; the user just types the SMS code as normal.
        },
        verificationFailed: (FirebaseAuthException e) {
          onFailed(_mapFirebaseError(e));
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          onCodeSent();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      onFailed('تعذر إرسال كود التفعيل. حاول مرة أخرى.');
    }
  }

  /// Confirms the SMS code and links the phone number to the currently
  /// signed-in user (the account created via [signUp]).
  Future<void> confirmOtpAndLinkPhone(String smsCode) async {
    if (_verificationId == null) {
      _errorMessage = 'حدث خطأ في التحقق. حاول إرسال الكود مرة أخرى.';
      throw AuthException(_errorMessage!);
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    await _run(() async {
      await _firebaseAuth.currentUser!.linkWithCredential(credential);
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
      throw AuthException(_errorMessage!); // 👈 أهم سطر
    } catch (e) {
      _errorMessage = 'حدث خطأ ما. حاول مرة أخرى.';
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