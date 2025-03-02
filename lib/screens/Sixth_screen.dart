// ignore_for_file: file_names

import 'package:fitopia2/screens/Eighth_screen.dart';
import 'package:fitopia2/screens/Seventh_screen.dart';
import 'package:flutter/material.dart';

class SixthScreen extends StatelessWidget {
  const SixthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/fitopia.jpg', width: 200),
                  const SizedBox(height: 70),
                  Text(
                    "Hesabına Giriş Yap",
                    style: TextStyle(
                      fontFamily: "Courgette-Regular",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 110, 141, 80),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                      hintText: "E-posta adresi...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color.fromARGB(255, 110, 141, 80),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      hintText: "Şifre...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color.fromARGB(255, 110, 141, 80),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EighthScreen(),));
                      },
                      child: const Text(
                        "Şifreni mi unuttun?",
                        style: TextStyle(color: Colors.red,fontSize: 15.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 110, 141, 80),
                      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text("Giriş", style: TextStyle(color: Colors.white, fontSize: 15.0,)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabın mı yok?",style: TextStyle(color: Colors.green, fontSize: 18.0)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SeventhScreen(),));
                        },
                        child: const Text("Hesap aç", style: TextStyle(color: Colors.red,fontSize: 18.0)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text("Hesabınla Devam Et", style: TextStyle(color: Colors.green, fontSize: 18.0)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(62, 173, 245, 153),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text("GOOGLE", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
