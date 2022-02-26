// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAVoB0vSIoztHSRFFTiWfbVuJNOLbYLSnU',
    appId: '1:195279935895:web:9c408ab3109ae9c5cf4cd2',
    messagingSenderId: '195279935895',
    projectId: 'time-money-tasklist',
    authDomain: 'time-money-tasklist.firebaseapp.com',
    storageBucket: 'time-money-tasklist.appspot.com',
    measurementId: 'G-D4ZH6BP1MC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuqe9Bn7SxOtHDU33KyERMwlsQGtX4XeI',
    appId: '1:195279935895:android:165e272e1dc0108fcf4cd2',
    messagingSenderId: '195279935895',
    projectId: 'time-money-tasklist',
    storageBucket: 'time-money-tasklist.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-WazQ_6KaTofLYZ4DOWAWRPfCXPof01c',
    appId: '1:195279935895:ios:7cc96e9c048042f3cf4cd2',
    messagingSenderId: '195279935895',
    projectId: 'time-money-tasklist',
    storageBucket: 'time-money-tasklist.appspot.com',
    iosClientId: '195279935895-v8bat76sd1e21lgh8n7q0pm3sckhsqir.apps.googleusercontent.com',
    iosBundleId: 'io.es.tmt',
  );
}
