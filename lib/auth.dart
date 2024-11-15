import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newfp/screen/login_screen.dart';
import 'package:newfp/screen/welcome_screen.dart';

class auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const WelcomeScreen();
          } else {
            return const LoginScreen();
          }
        }),
      ),
    );
  }
}
