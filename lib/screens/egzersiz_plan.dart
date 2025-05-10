import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EgzersizPlanim(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EgzersizPlanim extends StatefulWidget {
  const EgzersizPlanim({super.key});
  @override
  State<EgzersizPlanim> createState() => _EgzersizPlanimState();
}

class _EgzersizPlanimState extends State<EgzersizPlanim> {
  Duration duration = const Duration(hours: 0, minutes: 55, seconds: 42);
  Timer? timer;
  bool isRunning = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && duration.inSeconds > 0) {
        setState(() => duration -= const Duration(seconds: 1));
      } else {
        timer?.cancel();
      }
    });
  }

  void toggleTimer() {
    if (isRunning) {
      timer?.cancel();
    } else {
      startTimer();
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${d.inHours}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Üst rectangle
          Container(
            width: 393,
            height: 81,
            color: const Color(0xFFF9F7F3),
            alignment: Alignment.center,
            child: const Text(
              'Egzersiz Planım',
              style: TextStyle(
                fontFamily: 'Source Serif Pro',
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: Colors.black,
              ),
            ),
          ),

          // Elips ve gif
          Positioned(
            left: 85,
            top: 123,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 223,
                  height: 223,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCED2DE),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 223,
                  height: 223,
                  child: CircularProgressIndicator(
                    value: 0.25,
                    strokeWidth: 15,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF902C2F)),
                  ),
                ),
                SizedBox(
                  width: 167,
                  height: 167,
                  child: Image.asset(
                    'assets/overhead_press.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          // Zaman sayaç yazısı
          Positioned(
            left: 74,
            top: 368,
            child: SizedBox(
              width: 246,
              height: 60,
              child: Text(
                formatTime(duration),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Duraklat butonu
          Positioned(
            left: 115,
            top: 447,
            child: GestureDetector(
              onTap: toggleTimer,
              child: Container(
                width: 169,
                height: 39,
                decoration: BoxDecoration(
                  color: const Color(0xFF902C2F),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Duraklat',
                  style: TextStyle(
                    fontFamily: 'Source Serif Pro',
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Alt bilgi bölgesi
          Positioned(
            left: 0,
            top: 517,
            child: Container(
              width: 393,
              height: 180,
              color: const Color(0xFFFBB7B2),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 322,
                    height: 68,
                    child: Text(
                      'Overhead Press  •  16  •  30 kcal',
                      style: TextStyle(
                        fontFamily: 'Source Serif Pro',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bu egzersiz omuz kasları, kol kasları, bacak bel ve karın kaslarınızı çalıştırmaktadır.\nOverhead Press, daha büyük kollara sahip güçlü, kaslı ve sağlıklı omuzlar inşa etmek için en iyi egzersizlerden biridir.',
                    style: TextStyle(
                      fontFamily: 'Source Serif Pro',
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
