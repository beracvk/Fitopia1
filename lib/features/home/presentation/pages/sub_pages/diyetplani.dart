// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, file_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/meals/presentations/Ogle_screen.dart';
import 'package:fitopia2/features/meals/presentations/aksam_screen.dart';
import 'package:fitopia2/features/meals/presentations/ara_screen.dart';
import 'package:fitopia2/features/meals/presentations/kahvalti_screen.dart';

void main() {
  runApp(Diyetplani());
}

class Diyetplani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan görseli veya düz renk
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Color.fromARGB(77, 255, 255, 255)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Color.fromARGB(25, 255, 255, 255)),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Öğün Planı',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SourceSerif',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cuma, 14 Şubat',
                  style: TextStyle(
                    fontFamily: 'SourceSerif',
                    color: Color(0xFF196F3D),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatCard(label: 'Alınan', value: '200'),
                    _StatCard(label: 'Kalan', value: '1278', large: true),
                    _StatCard(label: 'Yakılan', value: '100'),
                  ],
                ),
                const SizedBox(height: 24),

                // Makro
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF0E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _MakroBox(title: 'Karbonhidrat', value: '0/100g'),
                      _MakroBox(title: 'Protein', value: '0/91g'),
                      _MakroBox(title: 'Yağlar', value: '0/69g'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Öğün kutuları
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _MealCard(
                      title: 'Kahvaltı',
                      imagePath: 'assets/images/breakfast.jpg',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => KahvaltiScreen()),
                      ),
                    ),
                    _MealCard(
                      title: 'Öğle Yemeği',
                      imagePath: 'assets/images/lunch.jpg',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OgleScreen()),
                      ),
                    ),
                    _MealCard(
                      title: 'Ara Öğün',
                      imagePath: 'assets/images/snack.jpg',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AraScreen()),
                      ),
                    ),
                    _MealCard(
                      title: 'Akşam Yemeği',
                      imagePath: 'assets/images/dinner.jpg',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AksamScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF6E8D50),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '“Yedikleriniz ilacınız, '
                   ' ilacınız yedikleriniz olsun.”'

                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool large;

  const _StatCard({required this.label, required this.value, this.large = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: large ? 28 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF196F3D),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MealCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _MealCard({required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: 160,
              height: 180,
              fit: BoxFit.cover,
            ),
            Container(
              width: 160,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'SourceSerif',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MakroBox extends StatelessWidget {
  final String title;
  final String value;

  const _MakroBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
