import 'screens/home_screen.dart' show HomeScreen;
import 'package:flutter/material.dart';

void main() {
  runApp(
     MyApp(),
    );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}




