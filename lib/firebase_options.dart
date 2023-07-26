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
    apiKey: 'AIzaSyClzQdnhVBVE1GAwf3xDF9HdG6sM6o32-s',
    appId: '1:405497052554:web:d95959d555b43e3cd61c73',
    messagingSenderId: '405497052554',
    projectId: 'company-task-organizer-20b5e',
    authDomain: 'company-task-organizer-20b5e.firebaseapp.com',
    storageBucket: 'company-task-organizer-20b5e.appspot.com',
    measurementId: 'G-J0HDCDRBWK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3OeykW4QPyGyZMlqNJBmp_yXbGmF81qA',
    appId: '1:405497052554:android:c4c386e97624456bd61c73',
    messagingSenderId: '405497052554',
    projectId: 'company-task-organizer-20b5e',
    storageBucket: 'company-task-organizer-20b5e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANiBN8U1RLYhBLBr-OkmBxN1hyT7DNcEk',
    appId: '1:405497052554:ios:906625284c3ab9aed61c73',
    messagingSenderId: '405497052554',
    projectId: 'company-task-organizer-20b5e',
    storageBucket: 'company-task-organizer-20b5e.appspot.com',
    iosClientId: '405497052554-1plflnfuddh229pbhv4c725i0249crlq.apps.googleusercontent.com',
    iosBundleId: 'com.example.companyTasksOrganizer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANiBN8U1RLYhBLBr-OkmBxN1hyT7DNcEk',
    appId: '1:405497052554:ios:906625284c3ab9aed61c73',
    messagingSenderId: '405497052554',
    projectId: 'company-task-organizer-20b5e',
    storageBucket: 'company-task-organizer-20b5e.appspot.com',
    iosClientId: '405497052554-1plflnfuddh229pbhv4c725i0249crlq.apps.googleusercontent.com',
    iosBundleId: 'com.example.companyTasksOrganizer',
  );
}
