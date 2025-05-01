import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// This is a placeholder file. You need to generate proper Firebase options by following these steps:
//
// 1. Create a Firebase project at: https://console.firebase.google.com/
// 2. Register your iOS/Android/Web apps in the Firebase console
// 3. Run the flutterfire configure command to generate this file:
//    $ dart pub global activate flutterfire_cli
//    $ flutterfire configure
//
// This will generate firebase_options.dart with the correct configuration for your project.

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // IMPORTANT: Replace these placeholder values with your actual Firebase configuration
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ios;
    } else {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not configured for this platform.',
      );
    }
  }

  // Android configuration - REPLACE THESE WITH YOUR ACTUAL VALUES
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR-ANDROID-API-KEY',
    appId: 'YOUR-ANDROID-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
  );

  // iOS configuration - REPLACE THESE WITH YOUR ACTUAL VALUES
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR-IOS-API-KEY',
    appId: 'YOUR-IOS-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    iosBundleId: 'YOUR-IOS-BUNDLE-ID',
  );
} 