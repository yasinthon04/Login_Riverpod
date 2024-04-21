import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isLoggedIn = authState.isLoggedIn;
    final username = authState.username;

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
                      Text('Welcome $username! You are logged in.'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider).logout();
                          Navigator.pushReplacementNamed(context, '/');
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
