import 'package:firebase_core/firebase_core.dart';
import 'package:fitopia2/services/firebase_options.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/home3_screen.dart';
import 'package:fitopia2/features/auth/presentation/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
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
      home: const Wrapper(),
      routes: {"/login": (context) => const HomeScreen(username: 'bera')},
    );
  }
}
