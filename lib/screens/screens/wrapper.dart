// ignore_for_file: unused_import

import 'package:fitopia2/screens/firebase_home_screen.dart';
import 'package:fitopia2/screens/home3_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_home_screen.dart';
import 'home_screen.dart'; // Giriş ekranın burada olsun

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const HomeScreen(); // Kullanıcı oturum açmışsa ana ekran
        } else {
          return const HomeScreen(); // Kullanıcı oturum açmamışsa giriş ekranı
        }
      },
    );
  }
}
