// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

class EighthScreen extends StatelessWidget {
  const EighthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/fitopia.jpg',
              height: 200,
            ),
            SizedBox(height: 100),
            Text(
              'Şifreni mi unuttun?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 110, 141, 80),
                shadows: [Shadow(color: Colors.black26)],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildOptionTile(Icons.email, 'E-POSTA', 'Kod e-posta adresinize gönderilecek'),
                  SizedBox(height: 40),
                  _buildOptionTile(Icons.phone, 'TELEFON', 'Kod telefon numaranıza gönderilecek'),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 110, 141, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 13),
                    ),
                    child: Text(
                      'Devam Et',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.1, horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 110, 141, 80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ),
    );
  }
}