// ignore_for_file: use_super_parameters, unused_import, prefer_typing_uninitialized_variables, undefined_shown_name

import 'package:flutter/material.dart';
import 'home3_screen.dart' show HomeScreen;
import 'screen/home3_screen.dart' show HomeScreen;
import 'screens/home3_screen.dart';
import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      home: const HomeScreen(),
    );
  }
}

mixin AppTheme {
  var lightTheme;
}