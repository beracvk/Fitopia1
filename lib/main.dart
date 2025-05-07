import 'package:firebase_core/firebase_core.dart';
import 'package:fitopia2/screens/screens/firebase_home_screen.dart';
import 'package:fitopia2/services/firebase_options.dart';
import 'package:flutter/material.dart';

// Ekranlar
import 'package:fitopia2/features/auth/presentation/wrapper.dart';
import 'package:fitopia2/features/auth/presentation/login_screen.dart';
import 'package:fitopia2/features/auth/presentation/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitopia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 🔍 Giriş yapılmış mı kontrol eden başlangıç ekranı
      home: const Wrapper(),

      // 📍 Rotalar tanımı
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/home": (context) => const FirebaseHomeScreen(), // Ana ekran
      },
    );
  }
}
