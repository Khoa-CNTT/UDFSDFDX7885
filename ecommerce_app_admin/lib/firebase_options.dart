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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC6ZV95wXfAQZeMAVuJrPDCE0JF3XByjJk',
    appId: '1:609090783650:web:9d599d33a54855702a4afb',
    messagingSenderId: '609090783650',
    projectId: 'datn-5ac73',
    authDomain: 'datn-5ac73.firebaseapp.com',
    storageBucket: 'datn-5ac73.firebasestorage.app',
    measurementId: 'G-2ZC2836CK5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7snCDf4Wq2huso9FoimPcJNkXQ8kVMgY',
    appId: '1:609090783650:android:0bae1e37c21ad6ad2a4afb',
    messagingSenderId: '609090783650',
    projectId: 'datn-5ac73',
    storageBucket: 'datn-5ac73.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSEU--J-XLuwSN_gnvmo92qhi89AADH1I',
    appId: '1:609090783650:ios:c5dfb55e88d86a9d2a4afb',
    messagingSenderId: '609090783650',
    projectId: 'datn-5ac73',
    storageBucket: 'datn-5ac73.firebasestorage.app',
    iosBundleId: 'com.example.ecommerceAppAdmin',
  );
}
