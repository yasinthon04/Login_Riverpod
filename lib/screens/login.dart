import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController =
        useTextEditingController(); // Flutter Hooks
    final TextEditingController passwordController =
        useTextEditingController(); // Flutter Hooks
    final isObscure = useState<bool>(true);
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 56.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 72),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                 suffixIcon: GestureDetector(
                    onTap: () {
                      isObscure.value = !isObscure.value;
                    },
                    child: Icon(
                      isObscure.value ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                  ),
                ),
                obscureText: isObscure.value,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final String username = usernameController.text.trim();
                  final String password = passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill in all fields.'),
                    ));
                    return;
                  }

                  final success = await auth.login(username, password);

                  if (success) {
                    // If login is successful, navigate to home screen
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // If login is unsuccessful, show an alert dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Login Failed',
                            style: TextStyle(color: Colors.black),
                          ),
                          content: const Text(
                            'Invalid username or password.',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                          backgroundColor: Colors.white,
                        );
                      },
                    );
                  }
                },
                child: SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
