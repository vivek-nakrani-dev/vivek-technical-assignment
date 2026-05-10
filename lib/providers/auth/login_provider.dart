import 'package:flutter/material.dart';
import 'package:vivek_technical_assignment/services/firebase_auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  LoginProvider(this._authService);

  bool isLoading = false;
  bool obscureText = true;

  void obscureTextToggle() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      await _authService.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
