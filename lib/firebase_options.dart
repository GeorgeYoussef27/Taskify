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
    apiKey: 'AIzaSyBukluUjG5SOLTSqt093i9Jzga1wNDNWto',
    appId: '1:561187222739:web:1046f1557e6d02ee885026',
    messagingSenderId: '561187222739',
    projectId: 'taskify-init',
    authDomain: 'taskify-init.firebaseapp.com',
    storageBucket: 'taskify-init.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGKODSm53Utlmj-zTQULZoz5bCMlIpuMU',
    appId: '1:561187222739:android:265339a1728980ad885026',
    messagingSenderId: '561187222739',
    projectId: 'taskify-init',
    storageBucket: 'taskify-init.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVE5XnpYlOl3sJGXRbhsGAbFLz3LF7IaU',
    appId: '1:561187222739:ios:a0719f9805c4bf73885026',
    messagingSenderId: '561187222739',
    projectId: 'taskify-init',
    storageBucket: 'taskify-init.firebasestorage.app',
    iosBundleId: 'com.example.taskify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVE5XnpYlOl3sJGXRbhsGAbFLz3LF7IaU',
    appId: '1:561187222739:ios:a0719f9805c4bf73885026',
    messagingSenderId: '561187222739',
    projectId: 'taskify-init',
    storageBucket: 'taskify-init.firebasestorage.app',
    iosBundleId: 'com.example.taskify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBukluUjG5SOLTSqt093i9Jzga1wNDNWto',
    appId: '1:561187222739:web:989da998f29c39fd885026',
    messagingSenderId: '561187222739',
    projectId: 'taskify-init',
    authDomain: 'taskify-init.firebaseapp.com',
    storageBucket: 'taskify-init.firebasestorage.app',
  );

}