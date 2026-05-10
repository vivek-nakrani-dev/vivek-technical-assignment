import 'package:firebase_auth/firebase_auth.dart';
import 'package:vivek_technical_assignment/utils/app_toast.dart';

class AppErrorHandler {
  static void handleAuthError(FirebaseAuthException error) {
    String message;

    switch (error.code) {
      case 'invalid-email':
        message = 'Invalid email address.';
        break;

      case 'user-disabled':
        message = 'This account has been disabled.';
        break;

      case 'user-not-found':
        message = 'No user found with this email.';
        break;

      case 'wrong-password':
        message = 'Incorrect password.';
        break;

      case 'email-already-in-use':
        message = 'Email is already registered.';
        break;

      case 'weak-password':
        message = 'Password is too weak.';
        break;

      case 'operation-not-allowed':
        message = 'This login method is not enabled.';
        break;

      case 'too-many-requests':
        message = 'Too many attempts. Try again later.';
        break;

      case 'network-request-failed':
        message = 'No internet connection.';
        break;

      case 'invalid-credential':
        message = 'The provided credential is invalid.';
        break;

      case 'account-exists-with-different-credential':
        message = 'Account already exists with a different sign-in method.';
        break;

      case 'credential-already-in-use':
        message = 'Credential is already in use.';
        break;

      case 'requires-recent-login':
        message = 'Please login again and retry.';
        break;

      case 'invalid-verification-code':
        message = 'Invalid verification code.';
        break;

      case 'invalid-verification-id':
        message = 'Invalid verification ID.';
        break;

      case 'session-expired':
        message = 'Session expired. Please try again.';
        break;

      default:
        message = 'An error occurred. Please try again.';
    }

    appToast(message: message);
  }
}
