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
    apiKey: 'AIzaSyDDsOlSWMyhF77mPp2cbOHqmlz8pPMCCHo',
    appId: '1:130152142177:web:e4eedc43a1304bf417e120',
    messagingSenderId: '130152142177',
    projectId: 'reto-asap',
    authDomain: 'reto-asap.firebaseapp.com',
    storageBucket: 'reto-asap.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtp1VJGzGPZEnUASZ7OUiYY1PcCscTf5s',
    appId: '1:130152142177:android:b7b9daa2002fe05717e120',
    messagingSenderId: '130152142177',
    projectId: 'reto-asap',
    storageBucket: 'reto-asap.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUA55Y5h8fgzMO2O05W6TTPFGlHE7sjW0',
    appId: '1:130152142177:ios:b3c32475866956cc17e120',
    messagingSenderId: '130152142177',
    projectId: 'reto-asap',
    storageBucket: 'reto-asap.appspot.com',
    iosBundleId: 'com.example.retoAsap',
  );
}
