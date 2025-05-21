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
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: const KahvaltiScreen(),
    );
  }
}

class KahvaltiScreen extends StatefulWidget {
  const KahvaltiScreen({super.key});

  @override
  State<KahvaltiScreen> createState() => _KahvaltiScreenState();
}

class _KahvaltiScreenState extends State<KahvaltiScreen> with TickerProviderStateMixin {
  String aiSuggestion = "";
  bool loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Random _random = Random();

  final List<Map<String, dynamic>> _kahvaltiOnerileri = [
    {
      'baslik': 'Sağlıklı Somon Tabağı',
      'aciklama': 'Fırında somon, patates ve taze sebze salatası ile besleyici başlangıç',
      'malzemeler': [
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140, 'ikon': '🍞'},
        {'ad': 'Haşlanmış yumurta', 'miktar': '1 adet', 'kalori': 70, 'ikon': '🥚'},
        {'ad': 'Sebze salatası', 'miktar': '1 porsiyon', 'kalori': 50, 'ikon': '🥗'},
      ],
      'toplamKalori': 260,
      'renk': Colors.green,
    },
    {
      'baslik': 'Yulaf Lapası Özel',
      'aciklama': 'Yulaf lapası, taze meyveler ve cevizle besleyici bir başlangıç',
      'malzemeler': [
        {'ad': 'Yulaf lapası', 'miktar': '1 kase', 'kalori': 150, 'ikon': '🥣'},
        {'ad': 'Muz', 'miktar': '1 orta boy', 'kalori': 105, 'ikon': '🍌'},
        {'ad': 'Ceviz', 'miktar': '1 avuç', 'kalori': 185, 'ikon': '🌰'},
      ],
      'toplamKalori': 440,
      'renk': Colors.amber,
    },
    {
      'baslik': 'Avokado Toast Delight',
      'aciklama': 'Avokado tost, cherry domates ve roka ile vitamin dolu lezzet',
      'malzemeler': [
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140, 'ikon': '🍞'},
        {'ad': 'Avokado', 'miktar': '1/2 adet', 'kalori': 160, 'ikon': '🥑'},
        {'ad': 'Cherry domates ve roka', 'miktar': '1 porsiyon', 'kalori': 25, 'ikon': '🍅'},
      ],
      'toplamKalori': 325,
      'renk': Colors.lightGreen,
    },
    {
      'baslik': 'Protein Omlet',
      'aciklama': 'Peynirli omlet, ıspanak ve mantar ile protein açısından zengin',
      'malzemeler': [
        {'ad': 'Yumurta', 'miktar': '2 adet', 'kalori': 140, 'ikon': '🥚'},
        {'ad': 'Beyaz peynir', 'miktar': '50g', 'kalori': 125, 'ikon': '🧀'},
        {'ad': 'Ispanak ve mantar', 'miktar': '1 porsiyon', 'kalori': 30, 'ikon': '🍄'},
      ],
      'toplamKalori': 295,
      'renk': Colors.orange,
    },
    {
      'baslik': 'Yunan Yoğurt Bowl',
      'aciklama': 'Yunan usulü yoğurt, bal ve granola ile probiyotik destek',
      'malzemeler': [
        {'ad': 'Yunan yoğurdu', 'miktar': '200g', 'kalori': 130, 'ikon': '🥛'},
        {'ad': 'Bal', 'miktar': '1 yemek kaşığı', 'kalori': 64, 'ikon': '🍯'},
        {'ad': 'Granola', 'miktar': '30g', 'kalori': 120, 'ikon': '🥣'},
      ],
      'toplamKalori': 314,
      'renk': Colors.purple,
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
      _mevcutOneri = _kahvaltiOnerileri[_random.nextInt(_kahvaltiOnerileri.length)];
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
              Colors.orange.withOpacity(0.1),
              Colors.white,
              Colors.orange.withOpacity(0.05),
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
                          'Günaydın! 🌅',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Kahvaltı Zamanı',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.restaurant_menu,
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
                          (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.1),
                          (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.2),
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
                                color: (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.star,
                                color: _mevcutOneri['renk'] ?? Colors.green,
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
                      colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withOpacity(0.4),
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
                                'AI Destekli Kahvaltı Rehberi',
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
                                  (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.1),
                                  (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: (_mevcutOneri['renk'] ?? Colors.green).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: _mevcutOneri['renk'] ?? Colors.green,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Toplam: ${_mevcutOneri['toplamKalori']} kcal',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _mevcutOneri['renk'] ?? Colors.green,
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