// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Egzersiz Planım',
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

class _FullScreenPageState extends State<FullScreenPage> with TickerProviderStateMixin {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false;
  
  String aiSuggestion = "";
  bool loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Random _random = Random();

  final List<Map<String, dynamic>> _egzersizOnerileri = [
    {
      'baslik': 'Overhead Press',
      'aciklama': 'Omuz, kol, bel ve karın kaslarınızı çalıştıran güçlü bir hareket',
      'kalori': '16-20 kcal',
      'sure': '3x12',
      'zorluk': 'Orta',
      'hedefKaslar': ['Omuz', 'Kol', 'Bel', 'Karın'],
      'renk': Color(0xFF6E8D50),
      'ikon': Icons.fitness_center,
    },
    {
      'baslik': 'Push-Up',
      'aciklama': 'Göğüs, kol ve core kaslarını güçlendiren temel egzersiz',
      'kalori': '12-15 kcal',
      'sure': '3x15',
      'zorluk': 'Kolay',
      'hedefKaslar': ['Göğüs', 'Kol', 'Core'],
      'renk': Color(0xFF4CAF50),
      'ikon': Icons.sports_gymnastics,
    },
    {
      'baslik': 'Squat',
      'aciklama': 'Bacak ve kalça kaslarını çalıştıran fonksiyonel hareket',
      'kalori': '18-25 kcal',
      'sure': '3x20',
      'zorluk': 'Orta',
      'hedefKaslar': ['Bacak', 'Kalça', 'Core'],
      'renk': Color(0xFF2196F3),
      'ikon': Icons.directions_walk,
    },
    {
      'baslik': 'Plank',
      'aciklama': 'Core stabilizasyonu ve dayanıklılık için mükemmel egzersiz',
      'kalori': '8-12 kcal',
      'sure': '3x45sn',
      'zorluk': 'Orta',
      'hedefKaslar': ['Core', 'Omuz', 'Sırt'],
      'renk': Color(0xFFFF9800),
      'ikon': Icons.self_improvement,
    },
    {
      'baslik': 'Burpee',
      'aciklama': 'Tüm vücut çalışan yüksek yoğunluklu kardio egzersizi',
      'kalori': '25-35 kcal',
      'sure': '3x10',
      'zorluk': 'Zor',
      'hedefKaslar': ['Tüm Vücut', 'Kardiyovasküler'],
      'renk': Color(0xFFE91E63),
      'ikon': Icons.sports_handball,
    },
    {
      'baslik': 'Lunges',
      'aciklama': 'Bacak kasları ve denge geliştiren unilateral hareket',
      'kalori': '14-20 kcal',
      'sure': '3x12',
      'zorluk': 'Orta',
      'hedefKaslar': ['Bacak', 'Kalça', 'Denge'],
      'renk': Color(0xFF9C27B0),
      'ikon': Icons.directions_run,
    },
  ];

  Map<String, dynamic> _mevcutEgzersiz = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    
    _rastgeleEgzersizGetir();
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

  void _rastgeleEgzersizGetir() {
    setState(() {
      _mevcutEgzersiz = _egzersizOnerileri[_random.nextInt(_egzersizOnerileri.length)];
    });
  }

  Future<void> getAISuggestion() async {
    setState(() {
      loading = true;
      aiSuggestion = "";
    });

    await Future.delayed(const Duration(seconds: 2));

    _rastgeleEgzersizGetir();
    _animationController.reset();
    _animationController.forward();

    setState(() {
      aiSuggestion = "suggestion_ready";
      loading = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildHedefKasItem(String kas, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(index * 0.1, 1.0, curve: Curves.easeOutBack),
          )),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (_mevcutEgzersiz['renk'] ?? Color(0xFF6E8D50)).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (_mevcutEgzersiz['renk'] ?? Color(0xFF6E8D50)).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                kas,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _mevcutEgzersiz['renk'] ?? Color(0xFF6E8D50),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('AI Egzersiz Planım'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(204, 110, 141, 80),
      ),
      body: Stack(
        children: [
          // Arka plan görseli
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6E8D50).withOpacity(0.1),
                  Colors.white,
                  Color(0xFF6E8D50).withOpacity(0.05),
                ],
              ),
            ),
          ),

          // Saydam beyaz katman
          Container(color: const Color.fromARGB(77, 255, 255, 255)),

          // Blur efekti
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: const Color.fromARGB(77, 255, 255, 255)),
          ),

          // İçerik
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hazır mısın? 💪',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Egzersiz Zamanı',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6E8D50),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6E8D50), Color(0xFF4CAF50)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF6E8D50).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Sayaç
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F0DA),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        formattedTime,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6E8D50),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: _toggleTimer,
                        icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                        label: Text(_isRunning ? 'Duraklat' : 'Başlat'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6E8D50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // AI Öneri Butonu
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6E8D50), Color(0xFF4CAF50)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6E8D50).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: loading ? null : getAISuggestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: loading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'AI Analiz Ediyor...',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.psychology,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'AI Egzersiz Önerisi Al',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 30),

                // AI Öneri Sonuçları
                if (aiSuggestion.isNotEmpty && !loading && _mevcutEgzersiz.isNotEmpty)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          // AI Başlık
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.psychology,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'AI Egzersiz Rehberi',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Egzersiz Kartı
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: (_mevcutEgzersiz['renk'] ?? Color(0xFF6E8D50)).withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Egzersiz Başlığı
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: (_mevcutEgzersiz['renk'] ?? Color(0xFF6E8D50)).withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        _mevcutEgzersiz['ikon'] ?? Icons.fitness_center,
                                        color: _mevcutEgzersiz['renk'] ?? Color(0xFF6E8D50),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _mevcutEgzersiz['baslik'] ?? '',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(
                                            _mevcutEgzersiz['zorluk'] ?? '',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Açıklama
                                Text(
                                  _mevcutEgzersiz['aciklama'] ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    height: 1.5,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Detaylar
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(Icons.local_fire_department, color: Colors.orange),
                                            SizedBox(height: 4),
                                            Text(
                                              _mevcutEgzersiz['kalori'] ?? '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(Icons.timer, color: Colors.blue),
                                            SizedBox(height: 4),
                                            Text(
                                              _mevcutEgzersiz['sure'] ?? '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Hedef Kaslar
                                Text(
                                  'Hedef Kaslar:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  children: (_mevcutEgzersiz['hedefKaslar'] as List<dynamic>?)
                                      ?.asMap()
                                      .entries
                                      .map((entry) => _buildHedefKasItem(entry.value, entry.key))
                                      .toList() ?? [],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                // Motivasyon
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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