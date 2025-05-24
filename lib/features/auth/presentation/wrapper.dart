import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fitopia2/screens/screens/home3_screen.dart';
import 'package:fitopia2/shared/firebase_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/onboarding/presentation/pages/home_screen.dart';
import 'package:fitopia2/features/auth/presentation/pages/Sixth_screen.dart';
// Giriş yapılınca yönlenecek ekran
// Giriş ekranı

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Future<bool> hasUserProfile(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data();
    if (data == null) return false;

    final yas = data['yas'] ?? 0;
    final kilo = data['kilo'] ?? 0;
    final boy = data['boy'] ?? 0;
    return yas > 0 && kilo > 0 && boy > 0;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          final user = snapshot.data!;
          return FutureBuilder<bool>(
            future: hasUserProfile(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.data == true) {
                return const FirebaseHomeScreen(); // profil tamam
              } else {
                return const ThirdScreen(); // eksik, profili doldur
              }
            },
          );
        } else {
          return const HomeScreen(); // giriş yapılmamışsa
        }
      },
    );
  }
}
