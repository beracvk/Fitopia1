// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp2());
}

class FigmaToCodeApp2 extends StatelessWidget {
  const FigmaToCodeApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF9F7F7),
      ),
      home: const FigmaToCodeApp3(),
    );
  }
}

class FigmaToCodeApp3 extends StatelessWidget {
  const FigmaToCodeApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Görüntü işleme için placeholder
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBE2EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      '📸 Kamera / Görüntü Önizleme Alanı',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF112D4E),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text("Kamera Aç"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F72AF),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_library, color: Colors.white),
                      label: const Text("Galeriden Seç"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F72AF),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6DDCC),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB0BEC5),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Porsiyon Analizim',
                        style: TextStyle(
                          color: Color(0xFFEB5A3C),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _FoodItemRow(name: '🥦 Brokoli', calorie: '39 Kalori', portion: 'Küçük'),
                      const Divider(thickness: 1, color: Color(0xFFEB5A3C)),
                      const _FoodItemRow(name: '🍅 Domates', calorie: '13 Kalori', portion: 'Orta'),
                      const Divider(thickness: 1, color: Color(0xFFEB5A3C)),
                      const _FoodItemRow(name: '🍳 Omlet', calorie: '154 Kalori', portion: 'Orta'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F72AF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '🌟 Küçük adımlar büyük değişiklikler yaratır! Sağlıklı kal! 🌿',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FoodItemRow extends StatelessWidget {
  final String name;
  final String calorie;
  final String portion;

  const _FoodItemRow({required this.name, required this.calorie, required this.portion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              calorie,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              portion,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}