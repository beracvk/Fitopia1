import 'package:flutter/material.dart';
// MyApp burada tanımlı mı?

void main() {
  runApp(MyApp()); // Fonksiyon gereksiz, doğrudan çağır
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Fitopia")),
        body: Center(child: Text("Hoş geldiniz!")),
      ),
    );
  }
}

