import 'package:flutter/material.dart';
import 'package:vivek_technical_assignment/services/firebase_auth_service.dart';

class RegisterProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  RegisterProvider(this._authService);

  bool isLoading = false;
  bool obscureTextPassword = true;
  bool obscureTextConfirm = true;

  void togglePasswordVisibility() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureTextConfirm = !obscureTextConfirm;
    notifyListeners();
  }

  Future<bool> register({required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      await _authService.createUserWithEmailAndPassword(email: email, password: password);
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
