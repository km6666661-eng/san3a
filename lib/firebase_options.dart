import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBO5Orz_JaEhJj5TIWb66FC7AfR3spyfWU',
    authDomain: 'san3a-9370a.firebaseapp.com',
    projectId: 'san3a-9370a',
    storageBucket: 'san3a-9370a.firebasestorage.app',
    messagingSenderId: '109740093303',
    appId: '1:109740093303:web:00000000000000000000',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBO5Orz_JaEhJj5TIWb66FC7AfR3spyfWU',
    appId: '1:109740093303:android:ab74ecc97308c12a233b72',
    messagingSenderId: '109740093303',
    projectId: 'san3a-9370a',
    storageBucket: 'san3a-9370a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUgxg8aVo-jr47MWYYOPtgMvJwG_4C5Gw',
    appId: '1:109740093303:ios:e9e772aee04a2b20233b72',
    messagingSenderId: '109740093303',
    projectId: 'san3a-9370a',
    storageBucket: 'san3a-9370a.firebasestorage.app',
  );

  static const FirebaseOptions macos = ios;

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBO5Orz_JaEhJj5TIWb66FC7AfR3spyfWU',
    appId: '1:109740093303:windows:ab74ecc97308c12a233b72',
    messagingSenderId: '109740093303',
    projectId: 'san3a-9370a',
    storageBucket: 'san3a-9370a.firebasestorage.app',
  );

  static const FirebaseOptions linux = windows;
}
