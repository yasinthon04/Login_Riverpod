import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isLoggedIn = authState.isLoggedIn; // Get the login status
    final username = authState.username; // Get the username

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoggedIn
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        username.split(' ').last, // Get the last word
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Text('You are not logged in.'),
          ],
        ),
      ),
    );
  }
}
