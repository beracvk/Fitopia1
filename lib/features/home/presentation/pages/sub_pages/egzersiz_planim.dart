import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Egzersiz Planım',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: const Color(0xFF6E8D50),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6E8D50),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const FullScreenPage(),
    );
  }
}

class FullScreenPage extends StatefulWidget {
  const FullScreenPage({super.key});

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isRunning) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  String get formattedTime {
    final hours = (_seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Egzersiz Planım'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(204, 110, 141, 80),
      ),
      body: Stack(
        children: [
          // 🎨 Arka plan görseli
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"), // varsa
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌫️ Saydam beyaz katman
          Container(color: const Color.fromARGB(77, 255, 255, 255),),

          // 💠 Blur efekti
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: const Color.fromARGB(77, 255, 255, 255),),
          ),

          // 📦 İçerik
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 📸 Egzersiz görseli
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/exercise.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                // ⏱ Sayaç
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F0DA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6E8D50),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ▶️ Buton
                ElevatedButton.icon(
                  onPressed: _toggleTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Duraklat' : 'Devam Et'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E8D50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),

                const SizedBox(height: 24),

                // 📋 Egzersiz Kartı
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Column(
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.fitness_center,
                                color: Color(0xFF6E8D50)),
                            SizedBox(width: 10),
                            Text(
                              'Overhead Press',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.local_fire_department_outlined,
                                color: Colors.deepOrange),
                            SizedBox(width: 10),
                            Text(
                              '16-20 kcal',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🧾 Açıklama
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF3E1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Bu egzersiz omuz, kol, bel ve karın kaslarınızı çalıştırır. '
                    'Daha büyük kollara sahip olmak ve güçlü omuzlar geliştirmek için en etkili egzersizlerden biridir.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),

                const SizedBox(height: 24),

                // 🌟 Motivasyon
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6E8D50),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Kendine inan, her tekrar seni hedefe bir adım daha yaklaştırır 💪',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
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
