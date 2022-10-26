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
    apiKey: 'AIzaSyAwMq1lV6-9WfCRwMUIe5Y641UnjExw1zY',
    appId: '1:514700413031:web:039a8c57896ec4f7166cc2',
    messagingSenderId: '514700413031',
    projectId: 'stock-in-a6ee1',
    authDomain: 'stock-in-a6ee1.firebaseapp.com',
    storageBucket: 'stock-in-a6ee1.appspot.com',
    measurementId: 'G-MHLXZFB13G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKJiRGfuZ4EPZMol7aCHBxrOQi0JKXB94',
    appId: '1:514700413031:android:289ba327a1cd7e22166cc2',
    messagingSenderId: '514700413031',
    projectId: 'stock-in-a6ee1',
    storageBucket: 'stock-in-a6ee1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-RV0bY9r61gR52C3TYY0SwVPmGZK-6Ak',
    appId: '1:514700413031:ios:358ffcdedacda457166cc2',
    messagingSenderId: '514700413031',
    projectId: 'stock-in-a6ee1',
    storageBucket: 'stock-in-a6ee1.appspot.com',
    iosClientId: '514700413031-v7jpr539h0qaeeaim5tpmml45450pdbu.apps.googleusercontent.com',
    iosBundleId: 'com.example.stockin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-RV0bY9r61gR52C3TYY0SwVPmGZK-6Ak',
    appId: '1:514700413031:ios:358ffcdedacda457166cc2',
    messagingSenderId: '514700413031',
    projectId: 'stock-in-a6ee1',
    storageBucket: 'stock-in-a6ee1.appspot.com',
    iosClientId: '514700413031-v7jpr539h0qaeeaim5tpmml45450pdbu.apps.googleusercontent.com',
    iosBundleId: 'com.example.stockin',
  );
}
