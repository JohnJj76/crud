
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
    apiKey: 'AIzaSyCdpf50IwOs4ANx_vLOYTjpXc9RrkIfp4Y',
    appId: '1:920057924975:web:17c5fe301bb46d75a36c9a',
    messagingSenderId: '920057924975',
    projectId: 'crud-jottace',
    authDomain: 'crud-jottace.firebaseapp.com',
    storageBucket: 'crud-jottace.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzitPVfD63rBtBNKdC2XOiZKeyJiKEcOA',
    appId: '1:920057924975:android:43bc210af6ffd490a36c9a',
    messagingSenderId: '920057924975',
    projectId: 'crud-jottace',
    storageBucket: 'crud-jottace.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC1x9EoaetXOGmSzi4Vw1z8WWl4Qa7dKM',
    appId: '1:920057924975:ios:de01f13248a3cecaa36c9a',
    messagingSenderId: '920057924975',
    projectId: 'crud-jottace',
    storageBucket: 'crud-jottace.appspot.com',
    iosClientId: '920057924975-r9kte74a3tq9npuaqgd0ja37lm8nfkf3.apps.googleusercontent.com',
    iosBundleId: 'com.jotta.crud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC1x9EoaetXOGmSzi4Vw1z8WWl4Qa7dKM',
    appId: '1:920057924975:ios:b49882617a2f3506a36c9a',
    messagingSenderId: '920057924975',
    projectId: 'crud-jottace',
    storageBucket: 'crud-jottace.appspot.com',
    iosClientId: '920057924975-qns9pqsm832g0lnsp56vfpo7dc4tttff.apps.googleusercontent.com',
    iosBundleId: 'com.jotta.crud.RunnerTests',
  );
}
