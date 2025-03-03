// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:fitopia2/screens/Home2-screen.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/screens/Home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home2Screen(),
    );
  }
}




