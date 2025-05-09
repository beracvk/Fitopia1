// ignore_for_file: file_names, unused_import, depend_on_referenced_packages

import 'package:fitopia2/features/onboarding/presentation/pages/Fourth_screen.dart';
import 'package:fitopia2/features/onboarding/presentation/pages/Third_screen.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 110, 141, 80),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hadi Başlayalım!',
                style: TextStyle(
                  fontFamily: "Courgette",
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FourthScreen()),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromARGB(255, 110, 141, 80),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
