import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
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
    apiKey: "AIzaSyBnktByAptQ4cXNyiXgxgBENV91pCehbo4",
    authDomain: "notebookcalculator.firebaseapp.com",
    projectId: "notebookcalculator",
    storageBucket: "notebookcalculator.firebasestorage.app",
    messagingSenderId: "460962411528",
    appId: "1:460962411528:web:2c5565c7ac17e72d7a0dbd",
    measurementId: "G-VKWHHC88KY",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBnktByAptQ4cXNyiXgxgBENV91pCehbo4",
    projectId: "notebookcalculator",
    storageBucket: "notebookcalculator.firebasestorage.app",
    messagingSenderId: "460962411528",
    appId: "1:460962411528:web:2c5565c7ac17e72d7a0dbd",
  );
}
