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
    apiKey: 'AIzaSyBkqIOoB3cB4pG9_0hANCjd1FRm2JDwFA0',
    appId: '1:785450236237:web:78b8c1d9a4493668765f04',
    messagingSenderId: '785450236237',
    projectId: 'practiceatthong',
    authDomain: 'practiceatthong.firebaseapp.com',
    storageBucket: 'practiceatthong.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFllzsckp8hi6SbOBVF96Etti4uW4l8QU',
    appId: '1:785450236237:android:0d6012c09f14f229765f04',
    messagingSenderId: '785450236237',
    projectId: 'practiceatthong',
    storageBucket: 'practiceatthong.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1ZQpjF-TbLeihVIcZ1nLm06p9AW4HnFs',
    appId: '1:785450236237:ios:d719ad9e7e85a532765f04',
    messagingSenderId: '785450236237',
    projectId: 'practiceatthong',
    storageBucket: 'practiceatthong.appspot.com',
    iosClientId: '785450236237-98nlcg8l7m6fmf5v5t831iir3d45ej55.apps.googleusercontent.com',
    iosBundleId: 'com.example.attendanceAppFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1ZQpjF-TbLeihVIcZ1nLm06p9AW4HnFs',
    appId: '1:785450236237:ios:0884458ea320b425765f04',
    messagingSenderId: '785450236237',
    projectId: 'practiceatthong',
    storageBucket: 'practiceatthong.appspot.com',
    iosClientId: '785450236237-88c5n6nr00vr110q33mu4gtj9flf2q1u.apps.googleusercontent.com',
    iosBundleId: 'com.example.attendanceAppFinal.RunnerTests',
  );
}
