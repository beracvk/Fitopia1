// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      home: const AksamScreen(),
    );
  }
}

class AksamScreen extends StatefulWidget {
  const AksamScreen({super.key});

  @override
  State<AksamScreen> createState() => _AksamScreenState();
}

class _AksamScreenState extends State<AksamScreen> with TickerProviderStateMixin {
  String aiSuggestion = "";
  bool loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Random _random = Random();

  final List<Map<String, dynamic>> _aksamYemegiOnerileri = [
    {
      'baslik': 'Izgara Tavuk Menüsü',
      'aciklama': 'Izgara tavuk göğsü, bulgur pilavı ve mevsim salatası ile dengeli akşam yemeği',
      'malzemeler': [
        {'ad': 'Izgara tavuk göğsü', 'miktar': '150g', 'kalori': 230, 'ikon': '🍗'},
        {'ad': 'Bulgur pilavı', 'miktar': '1 porsiyon', 'kalori': 180, 'ikon': '🍚'},
        {'ad': 'Mevsim salatası', 'miktar': '1 kase', 'kalori': 45, 'ikon': '🥗'},
      ],
      'toplamKalori': 455,
      'renk': Colors.red,
    },
    {
      'baslik': 'Somon Balık Tabağı',
      'aciklama': 'Fırında somon, patates püresi ve buharda brokoli ile omega-3 açısından zengin',
      'malzemeler': [
        {'ad': 'Fırında somon balığı', 'miktar': '120g', 'kalori': 280, 'ikon': '🐟'},
        {'ad': 'Patates püresi', 'miktar': '1 porsiyon', 'kalori': 210, 'ikon': '🥔'},
        {'ad': 'Buharda brokoli', 'miktar': '100g', 'kalori': 35, 'ikon': '🥦'},
      ],
      'toplamKalori': 525,
      'renk': Colors.teal,
    },
    {
      'baslik': 'Köfte ve Makarna',
      'aciklama': 'Ev yapımı köfte, makarna ve domates sosu ile geleneksel lezzet',
      'malzemeler': [
        {'ad': 'Ev yapımı köfte', 'miktar': '4 adet', 'kalori': 320, 'ikon': '🍖'},
        {'ad': 'Spagetti makarna', 'miktar': '80g', 'kalori': 280, 'ikon': '🍝'},
        {'ad': 'Domates sosu', 'miktar': '1 porsiyon', 'kalori': 65, 'ikon': '🍅'},
      ],
      'toplamKalori': 665,
      'renk': Colors.brown,
    },
    {
      'baslik': 'Vejeteryan Güveç',
      'aciklama': 'Sebze güveci, quinoa ve humus ile bitki bazlı protein kaynağı',
      'malzemeler': [
        {'ad': 'Karışık sebze güveci', 'miktar': '1 porsiyon', 'kalori': 150, 'ikon': '🍲'},
        {'ad': 'Quinoa', 'miktar': '80g', 'kalori': 120, 'ikon': '🌾'},
        {'ad': 'Humus', 'miktar': '60g', 'kalori': 180, 'ikon': '🥜'},
      ],
      'toplamKalori': 450,
      'renk': Colors.green,
    },
    {
      'baslik': 'Dana Etli Pilav',
      'aciklama': 'Kuşbaşı dana eti, pilav ve cacık ile Türk mutfağının klasiği',
      'malzemeler': [
        {'ad': 'Kuşbaşı dana eti', 'miktar': '100g', 'kalori': 250, 'ikon': '🥩'},
        {'ad': 'Tereyağlı pilav', 'miktar': '1 porsiyon', 'kalori': 220, 'ikon': '🍚'},
        {'ad': 'Cacık', 'miktar': '1 kase', 'kalori': 85, 'ikon': '🥒'},
      ],
      'toplamKalori': 555,
      'renk': Colors.orange,
    },
  ];

  Map<String, dynamic> _mevcutOneri = {};

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
    
    _rastgeleOneriGetir();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _rastgeleOneriGetir() {
    setState(() {
      _mevcutOneri = _aksamYemegiOnerileri[_random.nextInt(_aksamYemegiOnerileri.length)];
    });
  }

  Future<void> getAISuggestion() async {
    setState(() {
      loading = true;
      aiSuggestion = "";
    });

    await Future.delayed(const Duration(seconds: 2));

    _rastgeleOneriGetir();
    _animationController.reset();
    _animationController.forward();

    setState(() {
      aiSuggestion = "suggestion_ready";
      loading = false;
    });
  }

  Widget _buildMalzemeItem(Map<String, dynamic> malzeme, int index) {
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
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: _mevcutOneri['renk']?.withOpacity(0.2) ?? Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (_mevcutOneri['renk'] ?? Colors.grey).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        malzeme['ikon'] ?? '🍽',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          malzeme['ad'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          malzeme['miktar'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: (_mevcutOneri['renk'] ?? Colors.grey).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${malzeme['kalori']} kcal',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _mevcutOneri['renk'] ?? Colors.grey[700],
                      ),
                    ),
                  ),
                ],
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.1),
              Colors.white,
              Colors.red.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'İyi Akşamlar! 🌆',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Akşam Yemeği',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.dinner_dining,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Current Suggestion Card
                if (_mevcutOneri.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.1),
                          (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.star,
                                color: _mevcutOneri['renk'] ?? Colors.red,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Günün Önerisi',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _mevcutOneri['baslik'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _mevcutOneri['aciklama'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),

                // AI Suggestion Button
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD32F2F).withOpacity(0.4),
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
                                'Hazırlanıyor...',
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
                                'Yapay Zeka Önerisi Al',
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

                // AI Suggestion Results
                if (aiSuggestion.isNotEmpty && !loading && _mevcutOneri.isNotEmpty)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                'AI Destekli Akşam Yemeği Rehberi',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Malzemeler Listesi
                          ...(_mevcutOneri['malzemeler'] as List<dynamic>?)
                              ?.asMap()
                              .entries
                              .map((entry) => _buildMalzemeItem(entry.value, entry.key))
                              .toList() ?? [],

                          // Toplam Kalori
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.1),
                                  (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: (_mevcutOneri['renk'] ?? Colors.red).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: _mevcutOneri['renk'] ?? Colors.red,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Toplam: ${_mevcutOneri['toplamKalori']} kcal',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _mevcutOneri['renk'] ?? Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}