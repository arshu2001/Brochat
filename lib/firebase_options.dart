// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD1yxLlgyb_s4PQHKxIBHy12SPEARwDeBU',
    appId: '1:519843977308:web:e79d33d951847be2366e99',
    messagingSenderId: '519843977308',
    projectId: 'demo1-1016a',
    authDomain: 'demo1-1016a.firebaseapp.com',
    storageBucket: 'demo1-1016a.appspot.com',
    measurementId: 'G-S67W1X0GHP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAamC3sDTRSABcfRCCbwKsHJ7H_k1sfRpc',
    appId: '1:519843977308:android:6721f9eeb4972d2e366e99',
    messagingSenderId: '519843977308',
    projectId: 'demo1-1016a',
    storageBucket: 'demo1-1016a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTpq4o2fbSae7SSQoU3fmqq4zBkM8m3FU',
    appId: '1:519843977308:ios:3039c3c1dc45e2d4366e99',
    messagingSenderId: '519843977308',
    projectId: 'demo1-1016a',
    storageBucket: 'demo1-1016a.appspot.com',
    iosBundleId: 'com.example.demo1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTpq4o2fbSae7SSQoU3fmqq4zBkM8m3FU',
    appId: '1:519843977308:ios:0ea63841a1640ca1366e99',
    messagingSenderId: '519843977308',
    projectId: 'demo1-1016a',
    storageBucket: 'demo1-1016a.appspot.com',
    iosBundleId: 'com.example.demo1.RunnerTests',
  );
}