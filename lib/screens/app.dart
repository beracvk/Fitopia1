import 'package:flutter/material.dart';
import 'package:fitopia2/features/auth/presentation/pages/Sixth_screen.dart'; // ThirdScreen
// veya LoginPage kullanıyorsan onu import et

class MyApp extends StatelessWidget {
  // ignore: use_super_parameters
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      theme: ThemeData.light(),
      home: const ThirdScreen(), // 🔁 ilk sayfa giriş ekranı
    );
  }
}
