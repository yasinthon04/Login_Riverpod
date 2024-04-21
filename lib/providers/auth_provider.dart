import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:login_riverpod/services/auth_services.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;
  AuthProvider(this.ref);

  bool _isLoggedIn = false;
  String _username = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  Future<bool> login(String username, String password) async {
    final authService = ref.read(authServiceProvider);
    final success = await authService.login(username, password);
    if (success) {
      _isLoggedIn = true;
      _username = username;
    }
    notifyListeners();
    return success;
  }

  void logout() {
    final authService = ref.read(authServiceProvider);
    authService.logout();
    _isLoggedIn = false;
    _username = '';
    notifyListeners();
  }
}
