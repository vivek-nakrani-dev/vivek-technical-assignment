import 'package:firebase_auth/firebase_auth.dart';
import 'package:vivek_technical_assignment/utils/app_error_handler.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AppErrorHandler.handleAuthError(e);
      rethrow;
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      AppErrorHandler.handleAuthError(e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      AppErrorHandler.handleAuthError(e);
      rethrow;
    }
  }
}
