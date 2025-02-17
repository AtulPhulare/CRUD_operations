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
    apiKey: 'AIzaSyCz5-Yj0AXrnl6Ij2j8b2QvgeYwhZW7pjc',
    appId: '1:93783688717:web:951aa031b518e831baf744',
    messagingSenderId: '93783688717',
    projectId: 'crudoperations-e5d69',
    authDomain: 'crudoperations-e5d69.firebaseapp.com',
    storageBucket: 'crudoperations-e5d69.appspot.com',
    measurementId: 'G-Y2J3FFZBH7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW2DpODx2gj_dgFocRTb_ZJDDPMgtgyYs',
    appId: '1:93783688717:android:088751056b256567baf744',
    messagingSenderId: '93783688717',
    projectId: 'crudoperations-e5d69',
    storageBucket: 'crudoperations-e5d69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiCtdqZtJbwFPZAYYWNcpscbfRq_5J34k',
    appId: '1:93783688717:ios:4e304161ea33e203baf744',
    messagingSenderId: '93783688717',
    projectId: 'crudoperations-e5d69',
    storageBucket: 'crudoperations-e5d69.appspot.com',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiCtdqZtJbwFPZAYYWNcpscbfRq_5J34k',
    appId: '1:93783688717:ios:4e304161ea33e203baf744',
    messagingSenderId: '93783688717',
    projectId: 'crudoperations-e5d69',
    storageBucket: 'crudoperations-e5d69.appspot.com',
    iosBundleId: 'com.example.demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCz5-Yj0AXrnl6Ij2j8b2QvgeYwhZW7pjc',
    appId: '1:93783688717:web:5ffa3565ee9c7818baf744',
    messagingSenderId: '93783688717',
    projectId: 'crudoperations-e5d69',
    authDomain: 'crudoperations-e5d69.firebaseapp.com',
    storageBucket: 'crudoperations-e5d69.appspot.com',
    measurementId: 'G-G3GYFNYJ6N',
  );
}
