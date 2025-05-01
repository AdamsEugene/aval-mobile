import 'package:e_commerce_app/screen/auth/login_screen.dart';
import 'package:e_commerce_app/screen/splash_screen.dart';
// Commented out until proper Firebase configuration is set up
// import 'package:e_commerce_app/services/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Modified main function to handle Firebase initialization gracefully
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase initialization is commented out until proper configuration
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   if (kDebugMode) {
  //     print('Firebase initialized successfully');
  //   }
  // } catch (e) {
  //   if (kDebugMode) {
  //     print('Error initializing Firebase: $e');
  //   }
  // }
  
  runApp(const PageScaffoldApp());
}

class PageScaffoldApp extends StatelessWidget {
  const PageScaffoldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFEEEFF1),
        barBackgroundColor: Color(0xFFEEEFF1),
      ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 3500)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
