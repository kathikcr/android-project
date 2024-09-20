import 'package:android_project/features/auth/repository/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Image.asset(
                "assets/logo.png",
                height: 150,
              ),
            ),
            Text(
              "Welcome to EduTech",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.amber[800],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: GestureDetector(
                  onTap: () async {
                    await ref.read(authServiceProvider).signInWithGoogle();
                  },
                  child: Image.asset('assets/logo.png', height: 60)),
            ),
          ],
        ),
      )),
    );
  }
}
