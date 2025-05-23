// ignore_for_file: file_names, depend_on_referenced_packages, unused_import
import 'package:fitopia2/features/home/presentation/pages/sub_pages/fifth_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/auth/presentation/pages/Sixth_screen.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

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
          Image.asset('assets/images/eller.jpg', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ),
                Text(
                  "Sağlıklı ve dengeli bir yaşam için ilk adımını at!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Courgette-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 110, 141, 80),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Hayatını değiştirmeye hazır mısın?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Courgette-Regular',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 110, 141, 80),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 110, 141, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdScreen()),
                      );
                    },
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
