// ignore_for_file: use_super_parameters, unused_import, prefer_typing_uninitialized_variables, undefined_shown_name

import 'package:flutter/material.dart';
import '../features/home/presentation/pages/home3_screen.dart' as feature_home;
import 'screen/home3_screen.dart';
import 'screens/home3_screen.dart';
import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      home: const feature_home.HomeScreen(username: null),
    );
  }
}

mixin AppTheme {
  var lightTheme;
}
