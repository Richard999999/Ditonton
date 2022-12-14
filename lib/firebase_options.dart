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
    apiKey: 'AIzaSyBZ298R6iMXQ0wZwZQoF_NIBJfFEiR_sy8',
    appId: '1:173087667526:web:961ca104f6ce29856da147',
    messagingSenderId: '173087667526',
    projectId: 'ditonton-e7a3e',
    authDomain: 'ditonton-e7a3e.firebaseapp.com',
    storageBucket: 'ditonton-e7a3e.appspot.com',
    measurementId: 'G-059712LS9V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPhwatjkVkzL3ehqV6DKuJwxFXIyxBbRA',
    appId: '1:173087667526:android:d29b6351140e483d6da147',
    messagingSenderId: '173087667526',
    projectId: 'ditonton-e7a3e',
    storageBucket: 'ditonton-e7a3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAH28FAiA7Vu1M78nlR3EAqo80fzbgcd2o',
    appId: '1:173087667526:ios:f50c9133dd518cba6da147',
    messagingSenderId: '173087667526',
    projectId: 'ditonton-e7a3e',
    storageBucket: 'ditonton-e7a3e.appspot.com',
    iosClientId: '173087667526-41vqpldrgu8bu2659cgso7mn08givgit.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
