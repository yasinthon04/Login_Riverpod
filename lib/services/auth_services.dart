import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:login_riverpod/api_constants.dart';

class AuthService {
  
 Future<String?> auth(String username, String password) async {
  var body = {
    'username': username,
    'password': password,
  };

  var response = await http.post(
    Uri.parse("$baseUrl/login"),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    var jsonResponse = jsonDecode(response.body);
    print("token: ${jsonResponse['token']}");
    return jsonResponse['token']; // return the token for fetching data
  } else {
    print('Error: ${response.statusCode}');
    return null;
  }
}


  Future<String> fetchData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/data'),
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
    // Perform logout operations here
    print('Logged out');
  }
}

final authServiceProvider = Provider((ref) => AuthService());
