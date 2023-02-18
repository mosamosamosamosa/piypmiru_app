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
    apiKey: 'AIzaSyBbiPMIcESvOH6iJ2OU9Qmd3jkqx2T3Zs0',
    appId: '1:749646056782:web:9b37df8bc0aa1a3ccba21f',
    messagingSenderId: '749646056782',
    projectId: 'piyomiru-54705',
    authDomain: 'piyomiru-54705.firebaseapp.com',
    storageBucket: 'piyomiru-54705.appspot.com',
    measurementId: 'G-P1R2JXPJKD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY8wY8G98njXfol9ZMumN8yc-kXTl_UQY',
    appId: '1:749646056782:android:d3b10fc0495d9da6cba21f',
    messagingSenderId: '749646056782',
    projectId: 'piyomiru-54705',
    storageBucket: 'piyomiru-54705.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsslYZ_9Y37DeoQLbCHKmbNbGaY8l8V8I',
    appId: '1:749646056782:ios:d50518b37b132ba8cba21f',
    messagingSenderId: '749646056782',
    projectId: 'piyomiru-54705',
    storageBucket: 'piyomiru-54705.appspot.com',
    iosClientId: '749646056782-2626b8qcjtfs68vqomk1hu0lfffurn42.apps.googleusercontent.com',
    iosBundleId: 'com.example.piypmiruApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsslYZ_9Y37DeoQLbCHKmbNbGaY8l8V8I',
    appId: '1:749646056782:ios:d50518b37b132ba8cba21f',
    messagingSenderId: '749646056782',
    projectId: 'piyomiru-54705',
    storageBucket: 'piyomiru-54705.appspot.com',
    iosClientId: '749646056782-2626b8qcjtfs68vqomk1hu0lfffurn42.apps.googleusercontent.com',
    iosBundleId: 'com.example.piypmiruApp',
  );
}
