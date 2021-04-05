import '../../../../app/services/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SignInViewModel extends ChangeNotifier {
  String password;

  SignInViewModel(this.locator);

  final Locator locator;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signInAnonymously() async {
    _setLoading();
    await locator<FirebaseAuthService>().signInAnonymously();
    _setNotLoading();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _setLoading();
    await locator<FirebaseAuthService>()
        .signInWithEmailAndPassword(email, password);
    _setNotLoading();
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    _setLoading();
    await locator<FirebaseAuthService>()
        .signUpWithEmailAndPassword(email, password, name);
    _setNotLoading();
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
