import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String?> auth(String username, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://zrquf74pl0.execute-api.ap-southeast-1.amazonaws.com/default/flutter-test/login'));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final token = json.decode(responseBody)['token'];

      return token;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<String> fetchData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://zrquf74pl0.execute-api.ap-southeast-1.amazonaws.com/default/flutter-test/data'),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return 'Failed to fetch data';
      }
    } catch (e) {
      print('Request failed: $e');
      return 'Failed to fetch data';
    }
  }

  void logout() {
    print('Logged out');
  }
}

final authServiceProvider = Provider((ref) => AuthService());
