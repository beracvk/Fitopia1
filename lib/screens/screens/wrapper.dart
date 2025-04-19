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
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const FirebaseHomeScreen(); // Giriş yapılmışsa ana ekran
    } else {
      return const HomeScreen(); // Giriş yapılmamışsa login ekranı
    }
  }
}
