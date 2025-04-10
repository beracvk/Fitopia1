import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitopia2/screens/firebase_home_screen.dart'; // Firebase'den veri çeken ekranı içe aktar
import 'firebase_options.dart'; // Firebase yapılandırma dosyası

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter başlatılmadan önce işlemleri yap
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Firebase yapılandırması
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
      home:
          const FirebaseHomeScreen(), //  Firebase'den veri çeken ekran başlangıcı
    );
  }
}
