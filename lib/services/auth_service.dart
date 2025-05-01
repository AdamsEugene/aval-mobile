import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthResult {
  final User? user;
  final AuthStatus status;
  final String? errorMessage;

  AuthResult({
    this.user,
    required this.status,
    this.errorMessage,
  });

  bool get isSuccessful => status == AuthStatus.successful;
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Get current user
  User? get currentUser => _auth.currentUser;
  
  // Stream of authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return AuthResult(
          status: AuthStatus.unknown,
          errorMessage: 'Google sign in aborted',
        );
      }

      // Obtain the auth details from the Google sign-in
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return AuthResult(
        user: userCredential.user,
        status: AuthStatus.successful,
      );
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthException(e);
    } catch (e) {
      return AuthResult(
        status: AuthStatus.unknown,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Sign in with Facebook
  Future<AuthResult> signInWithFacebook() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.cancelled) {
        return AuthResult(
          status: AuthStatus.unknown,
          errorMessage: 'Facebook sign in cancelled',
        );
      }

      if (result.status == LoginStatus.failed) {
        return AuthResult(
          status: AuthStatus.unknown,
          errorMessage: 'Facebook sign in failed: ${result.message}',
        );
      }

      // Create Facebook credential
      final OAuthCredential facebookAuthCredential = 
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Sign in with credential
      final UserCredential userCredential = 
          await _auth.signInWithCredential(facebookAuthCredential);
      
      return AuthResult(
        user: userCredential.user,
        status: AuthStatus.successful,
      );
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthException(e);
    } catch (e) {
      return AuthResult(
        status: AuthStatus.unknown,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Sign in with Apple
  Future<AuthResult> signInWithApple() async {
    try {
      // Check if Apple sign in is available
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        return AuthResult(
          status: AuthStatus.unknown,
          errorMessage: 'Sign in with Apple is not available on this device',
        );
      }

      // Get Apple ID credentials
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create Apple credential
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      // Sign in with credential
      final userCredential = await _auth.signInWithCredential(oauthCredential);
      
      // Update missing name if needed (Apple doesn't always return name)
      if (userCredential.user != null && 
          (userCredential.user!.displayName == null || userCredential.user!.displayName!.isEmpty) &&
          credential.givenName != null) {
        await userCredential.user!.updateDisplayName(
          '${credential.givenName} ${credential.familyName ?? ''}',
        );
      }

      return AuthResult(
        user: userCredential.user,
        status: AuthStatus.successful,
      );
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthException(e);
    } on SignInWithAppleAuthorizationException catch (e) {
      return AuthResult(
        status: AuthStatus.unknown,
        errorMessage: e.message,
      );
    } catch (e) {
      return AuthResult(
        status: AuthStatus.unknown,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print("Error signing out: $e");
      }
    }
  }

  // Helper method to handle Firebase Auth exceptions
  AuthResult _handleFirebaseAuthException(FirebaseAuthException e) {
    AuthStatus status;
    String message = e.message ?? 'An unknown error occurred';

    switch (e.code) {
      case 'invalid-email':
        status = AuthStatus.invalidEmail;
        break;
      case 'wrong-password':
        status = AuthStatus.wrongPassword;
        break;
      case 'weak-password':
        status = AuthStatus.weakPassword;
        break;
      case 'email-already-in-use':
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }

    return AuthResult(
      status: status,
      errorMessage: message,
    );
  }
} 