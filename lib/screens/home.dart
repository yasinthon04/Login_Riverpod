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
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoggedIn
                ? Column(
                    children: [
                      Text(username),
                      Text('You are logged in.'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider).logout();
                          Navigator.pushReplacementNamed(
                              context, '/'); //go back to login screen
                        },
                        child: Text('Logout'),
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
