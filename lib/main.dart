import 'package:firebase_core/firebase_core.dart';
import 'package:fitopia2/firebase_options.dart';
import 'package:fitopia2/screens/home3_screen.dart';
import 'package:fitopia2/screens/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Wrapper(), // burada Wrapper widget’ı kullanılıyor
      routes: {
        "/login": (context) => const HomeScreen(), // Login ekran rotası
      },
    );
  }
}
