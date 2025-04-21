// ignore_for_file: unused_import

import 'package:fitopia2/features/auth/presentation/pages/Sixth_screen.dart';
import 'package:fitopia2/shared/firebase_home_screen.dart';
import 'package:fitopia2/features/home/presentation/pages/home3_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../screens/screens/home_screen.dart'; // Giriş ekranın burada olsun
import 'package:fitopia2/features/onboarding/presentation/pages/Third_screen.dart';

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
          return const FirebaseHomeScreen(); // Kullanıcı oturum açmışsa ana ekran
        } else {
          return const ThirdScreen(); // Kullanıcı oturum açmamışsa giriş ekranı
        }
      },
    );
  }
}
