import 'dart:async';
import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  late Duration remainingTime;
  Timer? timer;
  bool isPaused = false; // ⏸️ Duraklatma kontrolü

  @override
  void initState() {
    super.initState();
    remainingTime = const Duration(hours: 0, minutes: 55, seconds: 42);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPaused && remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      } else if (remainingTime.inSeconds == 0) {
        timer?.cancel();
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)} : ${twoDigits(d.inMinutes.remainder(60))} : ${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 246,
          height: 60,
          child: Text(
            formatDuration(remainingTime),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF902C2F),
              fontSize: 30,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: togglePause,
          child: Text(isPaused ? 'Devam Et' : 'Duraklat'),
        ),
      ],
    );
  }
}
