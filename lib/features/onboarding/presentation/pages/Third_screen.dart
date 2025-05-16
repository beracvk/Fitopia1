// ignore_for_file: file_names, unused_import, depend_on_referenced_packages

import 'package:fitopia2/features/onboarding/presentation/pages/Fourth_screen.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/Fifth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png', 
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Hedeflerine\nuygun önerilerle\nsağlıklı beslenmeyi\nkeşfet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Courgette-Regular",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 110, 141, 80),
                  ),
                ),
              ],
            ),
          ),
          Positioned( bottom: 87,
          right: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 110, 141, 80),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FifthScreen(),
                      ));
                    },
                    child: const Text(
                      "İleri",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
 