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
      title: 'Ara Öğün Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const AraScreen(),
    );
  }
}

class AraScreen extends StatefulWidget {
  const AraScreen({super.key});

  @override
  State<AraScreen> createState() => _AraScreenState();
}

class _AraScreenState extends State<AraScreen> with TickerProviderStateMixin {
  String aiSuggestion = "";
  bool loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Random _random = Random();

  final List<Map<String, dynamic>> _araOgunOnerileri = [
    {
      'baslik': 'Meyve ve Yoğurt Mix',
      'aciklama': 'Protein ve vitamin açısından zengin, hafif ve besleyici ara öğün',
      'malzemeler': [
        {'ad': 'Yunan yoğurdu', 'miktar': '150g', 'kalori': 100, 'ikon': '🥛'},
        {'ad': 'Çilek', 'miktar': '100g', 'kalori': 32, 'ikon': '🍓'},
        {'ad': 'Muz', 'miktar': '1 küçük', 'kalori': 90, 'ikon': '🍌'},
        {'ad': 'Bal', 'miktar': '1 tatlı kaşığı', 'kalori': 32, 'ikon': '🍯'},
      ],
      'toplamKalori': 254,
      'renk': Colors.pink,
    },
    {
      'baslik': 'Kuruyemiş Karışımı',
      'aciklama': 'Beyin fonksiyonlarını destekleyen omega-3 açısından zengin atıştırmalık',
      'malzemeler': [
        {'ad': 'Ceviz', 'miktar': '20g', 'kalori': 131, 'ikon': '🌰'},
        {'ad': 'Badem', 'miktar': '15g', 'kalori': 87, 'ikon': '🥜'},
        {'ad': 'Fındık', 'miktar': '15g', 'kalori': 94, 'ikon': '🌰'},
        {'ad': 'Kuru üzüm', 'miktar': '20g', 'kalori': 60, 'ikon': '🍇'},
      ],
      'toplamKalori': 372,
      'renk': Colors.brown,
    },
    {
      'baslik': 'Smoothie Bowl',
      'aciklama': 'Antioksidan zengini, vitamin ve mineral deposu sağlıklı içecek',
      'malzemeler': [
        {'ad': 'Muz', 'miktar': '1 orta boy', 'kalori': 105, 'ikon': '🍌'},
        {'ad': 'Çilek', 'miktar': '80g', 'kalori': 26, 'ikon': '🍓'},
        {'ad': 'Yaban mersini', 'miktar': '50g', 'kalori': 29, 'ikon': '🫐'},
        {'ad': 'Süt', 'miktar': '200ml', 'kalori': 120, 'ikon': '🥛'},
      ],
      'toplamKalori': 280,
      'renk': Colors.purple,
    },
    {
      'baslik': 'Avokado Toast Mini',
      'aciklama': 'Sağlıklı yağlar ve lif açısından zengin, tok tutan ara öğün',
      'malzemeler': [
        {'ad': 'Çavdar ekmeği', 'miktar': '1 dilim', 'kalori': 83, 'ikon': '🍞'},
        {'ad': 'Avokado', 'miktar': '1/3 adet', 'kalori': 107, 'ikon': '🥑'},
        {'ad': 'Lime suyu', 'miktar': '1 tatlı kaşığı', 'kalori': 2, 'ikon': '🍋'},
        {'ad': 'Cherry domates', 'miktar': '3 adet', 'kalori': 18, 'ikon': '🍅'},
      ],
      'toplamKalori': 210,
      'renk': Colors.green,
    },
    {
      'baslik': 'Protein Bar Alternatifi',
      'aciklama': 'Ev yapımı, doğal protein kaynağı ile enerji verici ara öğün',
      'malzemeler': [
        {'ad': 'Hurma', 'miktar': '3 adet', 'kalori': 66, 'ikon': '🏺'},
        {'ad': 'Fıstık ezmesi', 'miktar': '1 yemek kaşığı', 'kalori': 94, 'ikon': '🥜'},
        {'ad': 'Chia tohumu', 'miktar': '1 tatlı kaşığı', 'kalori': 20, 'ikon': '🌱'},
        {'ad': 'Kakao tozu', 'miktar': '1 tatlı kaşığı', 'kalori': 12, 'ikon': '🍫'},
      ],
      'toplamKalori': 192,
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
      _mevcutOneri = _araOgunOnerileri[_random.nextInt(_araOgunOnerileri.length)];
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
                          'Afiyet Olsun! 🍽️',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ara Öğün Zamanı',
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
                          colors: [Colors.blue, Colors.indigo],
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
                        Icons.fastfood,
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
                      colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2196F3).withOpacity(0.4),
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
                                'AI Destekli Ara Öğün Rehberi',
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