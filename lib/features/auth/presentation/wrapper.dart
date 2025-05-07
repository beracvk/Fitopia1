import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopia2/shared/firebase_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/onboarding/presentation/pages/home_screen.dart';
// Giriş yapılınca yönlenecek ekran
// Giriş ekranı

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
          return const FirebaseHomeScreen(); // Giriş yapılmışsa
        } else {
          return const HomeScreen(); // Giriş yapılmamışsa
        }
      },
    );
  }
}
