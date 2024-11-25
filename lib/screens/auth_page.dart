import 'package:comet/screens/login_or_register_page.dart';
import 'package:comet/screens/navbarpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier; // Add this parameter

  const AuthPage({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // User is logged in
            if (snapshot.hasData) {
              return BottomNavigationBarPage(themeNotifier: themeNotifier,);
            }
            // User is not logged in
            else {
              return LoginOrRegisterPage();
            }
          }),
    );
  }
}
