import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod/services/auth_services.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;
  AuthProvider(this.ref);

  bool _isLoggedIn = false;
  String _username = '';
  String? _token;

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String? get token => _token;

  Future<bool> login(String username, String password) async {
    final authService = ref.read(authServiceProvider);
    final token = await authService.auth(username, password);
    if (token != null) {
      _isLoggedIn = true;
      _token = token;
      await fetchData();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> fetchData() async {
    if (_isLoggedIn && _token != null) {
      final authService = ref.read(authServiceProvider);
      final response = await authService.fetchData(_token!);
      _username = response; // Set the username to the response
    } else {
      print('User is not logged in or token is null');
    }
  }

  void logout() {
    final authService = ref.read(authServiceProvider);
    authService.logout();
    _isLoggedIn = false;
    _username = '';
    _token = null;
    notifyListeners();
  }
}
