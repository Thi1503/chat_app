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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAyI60drFBAnLC0PRNlGnSjAywRf0jvkE',
    appId: '1:170646443550:android:5b2f983cb3d4ee8181400f',
    messagingSenderId: '170646443550',
    projectId: 'flutter-prep-a3c7b',
    databaseURL: 'https://flutter-prep-a3c7b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-a3c7b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsrGV7Tto5pWUiSMxLagxF1SeE8CFHero',
    appId: '1:170646443550:ios:194b567005435a5b81400f',
    messagingSenderId: '170646443550',
    projectId: 'flutter-prep-a3c7b',
    databaseURL: 'https://flutter-prep-a3c7b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-a3c7b.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

}