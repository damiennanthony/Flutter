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
   // ignore: missing_enum_constant_in_switch
   switch (defaultTargetPlatform) {
     case TargetPlatform.android:
       return android;
     case TargetPlatform.iOS:
       return ios;
     case TargetPlatform.macOS:
       return macos;
     case TargetPlatform.fuchsia:
       // TODO: Handle this case.
     case TargetPlatform.linux:
       // TODO: Handle this case.
     case TargetPlatform.windows:
       // TODO: Handle this case.
   }

   throw UnsupportedError(
     'DefaultFirebaseOptions are not supported for this platform.',
   );
 }

 static const FirebaseOptions web = FirebaseOptions(
   apiKey: 'AIzaSyA_hh7jyzCLv4n5ezToi1wP6d0DZOS_Vwg',
   appId: '1:198725786540:android:ae2cf7e06d125e28b5b809',
   messagingSenderId: '198725786540',
   projectId: 'flutter-project-1-a4d94',
   authDomain: 'flutterfire-ui-codelab.firebaseapp.com',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
   measurementId: 'G-DGF0CP099H',
 );

 static const FirebaseOptions android = FirebaseOptions(
   apiKey: 'AIzaSyA_hh7jyzCLv4n5ezToi1wP6d0DZOS_Vwg',
   appId: '1:198725786540:android:ae2cf7e06d125e28b5b809',
   messagingSenderId: '198725786540',
   projectId: 'flutter-project-1-a4d94',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
 );

 static const FirebaseOptions ios = FirebaseOptions(
   apiKey: 'AIzaSyA_hh7jyzCLv4n5ezToi1wP6d0DZOS_Vwg',
   appId: '1:198725786540:android:ae2cf7e06d125e28b5b809',
   messagingSenderId: '198725786540',
   projectId: 'flutter-project-1-a4d94',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
   iosClientId: '963656261848-v7r3vq1v6haupv0l1mdrmsf56ktnua60.apps.googleusercontent.com',
   iosBundleId: 'com.example.complete',
 );

 static const FirebaseOptions macos = FirebaseOptions(
   apiKey: 'AIzaSyA_hh7jyzCLv4n5ezToi1wP6d0DZOS_Vwg',
   appId: '1:198725786540:android:ae2cf7e06d125e28b5b809',
   messagingSenderId: '198725786540',
   projectId: 'flutter-project-1-a4d94',
   storageBucket: 'flutterfire-ui-codelab.appspot.com',
   iosClientId: '963656261848-v7r3vq1v6haupv0l1mdrmsf56ktnua60.apps.googleusercontent.com',
   iosBundleId: 'com.example.complete',
 );
}