import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> login(String username, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://zrquf74pl0.execute-api.ap-southeast-1.amazonaws.com/default/flutter-test/login'));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
    
  }

  void logout() {
    // Logout logic if needed
    print('Logged out');
  }
}

final authServiceProvider = Provider((ref) => AuthService());
