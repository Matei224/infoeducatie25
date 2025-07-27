import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyB73R4BgSYe_fgI-tsqy0axTi1W0peJY5c',
    appId: '1:145278090577:android:509fc34381141f44f82770',
    messagingSenderId: '145278090577',
    projectId: 'studee-357dd',
    databaseURL: 'https://studee-357dd-default-rtdb.firebaseio.com',
    storageBucket: 'studee-357dd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC23n9JfFJkrV1EfQF9LMLBmGqInsgHP4U',
    appId: '1:145278090577:ios:90427f94edc921ddf82770',
    messagingSenderId: '145278090577',
    projectId: 'studee-357dd',
    databaseURL: 'https://studee-357dd-default-rtdb.firebaseio.com',
    storageBucket: 'studee-357dd.firebasestorage.app',
    iosClientId: '145278090577-i8v837smeuva4plr2tnsnnt95o7br0ts.apps.googleusercontent.com',
    iosBundleId: 'com.example.studeeApp',
  );

}