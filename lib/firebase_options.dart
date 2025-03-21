// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD36rh1M18AJ2j1zd62Kzy0o1ThJu11LdU',
    appId: '1:721273771876:web:20df6e504b990165cacc71',
    messagingSenderId: '721273771876',
    projectId: 'project-1-2fff0',
    authDomain: 'project-1-2fff0.firebaseapp.com',
    storageBucket: 'project-1-2fff0.firebasestorage.app',
    measurementId: 'G-VNBP1L661H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTeuNZx03yi3pnN8l1q0Rv_jDuOnLBOPw',
    appId: '1:721273771876:android:41ebebf3aa3d0a0ccacc71',
    messagingSenderId: '721273771876',
    projectId: 'project-1-2fff0',
    storageBucket: 'project-1-2fff0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkKDPWPSxqpLODek9R6PUQ_lgU4gJKXC0',
    appId: '1:721273771876:ios:a65b5be57bc4cf60cacc71',
    messagingSenderId: '721273771876',
    projectId: 'project-1-2fff0',
    storageBucket: 'project-1-2fff0.firebasestorage.app',
    iosBundleId: 'com.example.recipeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkKDPWPSxqpLODek9R6PUQ_lgU4gJKXC0',
    appId: '1:721273771876:ios:a65b5be57bc4cf60cacc71',
    messagingSenderId: '721273771876',
    projectId: 'project-1-2fff0',
    storageBucket: 'project-1-2fff0.firebasestorage.app',
    iosBundleId: 'com.example.recipeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD36rh1M18AJ2j1zd62Kzy0o1ThJu11LdU',
    appId: '1:721273771876:web:ec49fe0c38d2e68ecacc71',
    messagingSenderId: '721273771876',
    projectId: 'project-1-2fff0',
    authDomain: 'project-1-2fff0.firebaseapp.com',
    storageBucket: 'project-1-2fff0.firebasestorage.app',
    measurementId: 'G-10NG51LJKB',
  );
}
