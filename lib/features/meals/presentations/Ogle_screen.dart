// ignore_for_file: deprecated_member_use, file_names

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
      title: 'Öğle Yemeği Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const OgleScreen(),
    );
  }
}

class OgleScreen extends StatefulWidget {
  const OgleScreen({super.key});

  @override
  State<OgleScreen> createState() => _OgleScreenState();
}

class _OgleScreenState extends State<OgleScreen> with TickerProviderStateMixin {
  String aiSuggestion = "";
  bool loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Random _random = Random();

  final List<Map<String, dynamic>> _ogleYemegiOnerileri = [
    {
      'baslik': 'Izgara Tavuk Salata',
      'aciklama': 'Protein dolu ızgara tavuk, taze yeşillikler ve sebzelerle hafif öğle yemeği',
      'malzemeler': [
        {'ad': 'Izgara tavuk göğsü', 'miktar': '150g', 'kalori': 185, 'ikon': '🍗'},
        {'ad': 'Karışık yeşillik', 'miktar': '100g', 'kalori': 20, 'ikon': '🥬'},
        {'ad': 'Cherry domates', 'miktar': '100g', 'kalori': 18, 'ikon': '🍅'},
        {'ad': 'Avokado', 'miktar': '1/2 adet', 'kalori': 160, 'ikon': '🥑'},
        {'ad': 'Zeytinyağı sosu', 'miktar': '1 y.k.', 'kalori': 120, 'ikon': '🫒'},
      ],
      'toplamKalori': 503,
      'renk': Colors.green,
    },
    {
      'baslik': 'Somon Teriyaki Bowl',
      'aciklama': 'Teriyaki soslu somon, quinoa ve buğuday noodle ile Asya usulü',
      'malzemeler': [
        {'ad': 'Somon fileto', 'miktar': '120g', 'kalori': 206, 'ikon': '🐟'},
        {'ad': 'Pişmiş quinoa', 'miktar': '100g', 'kalori': 120, 'ikon': '🌾'},
        {'ad': 'Teriyaki sos', 'miktar': '2 y.k.', 'kalori': 60, 'ikon': '🥢'},
        {'ad': 'Buharda sebze', 'miktar': '150g', 'kalori': 45, 'ikon': '🥦'},
        {'ad': 'Susam', 'miktar': '1 t.k.', 'kalori': 52, 'ikon': '🌱'},
      ],
      'toplamKalori': 483,
      'renk': Colors.orange,
    },
    {
      'baslik': 'Köfte Bulgur Pilav',
      'aciklama': 'Ev yapımı köfte, bulgur pilav ve cacık ile geleneksel Türk yemeği',
      'malzemeler': [
        {'ad': 'Köfte', 'miktar': '4 adet', 'kalori': 280, 'ikon': '🍖'},
        {'ad': 'Bulgur pilavı', 'miktar': '1 porsiyon', 'kalori': 180, 'ikon': '🍚'},
        {'ad': 'Cacık', 'miktar': '100g', 'kalori': 60, 'ikon': '🥒'},
        {'ad': 'Turşu', 'miktar': '50g', 'kalori': 12, 'ikon': '🥕'},
        {'ad': 'Yeşil salata', 'miktar': '1 porsiyon', 'kalori': 25, 'ikon': '🥗'},
      ],
      'toplamKalori': 557,
      'renk': Colors.red,
    },
    {
      'baslik': 'Falafel Wrap',
      'aciklama': 'Vegan falafel, humus ve taze sebzelerle doyurucu wrap',
      'malzemeler': [
        {'ad': 'Lavash ekmeği', 'miktar': '1 adet', 'kalori': 120, 'ikon': '🌯'},
        {'ad': 'Falafel', 'miktar': '4 adet', 'kalori': 220, 'ikon': '🧆'},
        {'ad': 'Humus', 'miktar': '2 y.k.', 'kalori': 70, 'ikon': '🫘'},
        {'ad': 'Sebze karışımı', 'miktar': '100g', 'kalori': 30, 'ikon': '🥒'},
        {'ad': 'Tahin sosu', 'miktar': '1 y.k.', 'kalori': 60, 'ikon': '🥜'},
      ],
      'toplamKalori': 500,
      'renk': Colors.brown,
    },
    {
      'baslik': 'Kremalı Mantarlı Risotto',
      'aciklama': 'İtalyan usulü kremalı mantar risottosu, parmesan peyniri ile',
      'malzemeler': [
        {'ad': 'Arborio pirinç', 'miktar': '80g', 'kalori': 290, 'ikon': '🍚'},
        {'ad': 'Karışık mantar', 'miktar': '150g', 'kalori': 35, 'ikon': '🍄'},
        {'ad': 'Parmesan peyniri', 'miktar': '30g', 'kalori': 110, 'ikon': '🧀'},
        {'ad': 'Krema', 'miktar': '50ml', 'kalori': 100, 'ikon': '🥛'},
        {'ad': 'Beyaz şarap', 'miktar': '2 y.k.', 'kalori': 20, 'ikon': '🍷'},
      ],
      'toplamKalori': 555,
      'renk': Colors.purple,
    },
    {
      'baslik': 'Ton Balıklı Salata',
      'aciklama': 'Konserve ton balığı, fasulye ve sebzelerle protein deposu',
      'malzemeler': [
        {'ad': 'Ton balığı', 'miktar': '1 kutu', 'kalori': 180, 'ikon': '🐟'},
        {'ad': 'Beyaz fasulye', 'miktar': '100g', 'kalori': 140, 'ikon': '🫘'},
        {'ad': 'Mısır', 'miktar': '50g', 'kalori': 45, 'ikon': '🌽'},
        {'ad': 'Karışık salata', 'miktar': '150g', 'kalori': 25, 'ikon': '🥗'},
        {'ad': 'Limon-zeytinyağı', 'miktar': '1 y.k.', 'kalori': 100, 'ikon': '🍋'},
      ],
      'toplamKalori': 490,
      'renk': Colors.teal,
    },
    {
      'baslik': 'Etli Nohut Yahnisi',
      'aciklama': 'Geleneksel etli nohut yahnisi, pilav ve yoğurt ile',
      'malzemeler': [
        {'ad': 'Kuşbaşı et', 'miktar': '100g', 'kalori': 250, 'ikon': '🥩'},
        {'ad': 'Nohut', 'miktar': '150g', 'kalori': 240, 'ikon': '🫛'},
        {'ad': 'Pilav', 'miktar': '1 porsiyon', 'kalori': 150, 'ikon': '🍚'},
        {'ad': 'Yoğurt', 'miktar': '100g', 'kalori': 60, 'ikon': '🥛'},
        {'ad': 'Salata', 'miktar': '1 porsiyon', 'kalori': 30, 'ikon': '🥗'},
      ],
      'toplamKalori': 730,
      'renk': Colors.deepOrange,
    },
    {
      'baslik': 'Sebzeli Omlet',
      'aciklama': 'Karışık sebzeli omlet, roka salatası ve tam buğday ekmeği',
      'malzemeler': [
        {'ad': 'Yumurta', 'miktar': '3 adet', 'kalori': 210, 'ikon': '🥚'},
        {'ad': 'Karışık sebze', 'miktar': '100g', 'kalori': 35, 'ikon': '🥬'},
        {'ad': 'Roka salatası', 'miktar': '50g', 'kalori': 12, 'ikon': '🌿'},
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140, 'ikon': '🍞'},
        {'ad': 'Tereyağı', 'miktar': '1 t.k.', 'kalori': 100, 'ikon': '🧈'},
      ],
      'toplamKalori': 497,
      'renk': Colors.amber,
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
      _mevcutOneri = _ogleYemegiOnerileri[_random.nextInt(_ogleYemegiOnerileri.length)];
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
              Colors.blue.withOpacity(0.1),
              Colors.white,
              Colors.blue.withOpacity(0.05),
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
                          'Öğle Vakti! ☀',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Öğle Yemeği',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.lightBlue],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lunch_dining,
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
                          (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.1),
                          (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.2),
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
                                color: (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.star,
                                color: _mevcutOneri['renk'] ?? Colors.blue,
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
                      colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1976D2).withOpacity(0.4),
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
                                'AI Destekli Öğle Yemeği Rehberi',
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
                                  (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.1),
                                  (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: (_mevcutOneri['renk'] ?? Colors.blue).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: _mevcutOneri['renk'] ?? Colors.blue,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Toplam: ${_mevcutOneri['toplamKalori']} kcal',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _mevcutOneri['renk'] ?? Colors.blue,
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