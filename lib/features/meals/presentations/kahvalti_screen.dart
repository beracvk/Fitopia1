// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math'; // ← Bu import'u ekledik

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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const KahvaltiScreen(),
    );
  }
}

class KahvaltiScreen extends StatefulWidget {
  const KahvaltiScreen({super.key});

  @override
  State<KahvaltiScreen> createState() => _KahvaltiScreenState();
}

class _KahvaltiScreenState extends State<KahvaltiScreen> {
  String aiSuggestion = "";
  bool loading = false;

  // ← Yeni eklenen değişkenler
  final Random _random = Random();

  final List<Map<String, dynamic>> _kahvaltiOnerileri = [
    {
      'aciklama':
          'Fırında Somon, fırında patates, sebze salatası (brokoli, karnıbahar, kabak, patlıcan).',
      'oneri':
          'Öneri: 2 dilim tam buğday ekmeği (140 kcal), 1 adet haşlanmış yumurta (70 kcal), 1 porsiyon sebze salatası (50 kcal), toplam 260 kcal.',
    },
    {
      'aciklama':
          'Yulaf lapası, taze meyveler ve cevizle besleyici bir başlangıç.',
      'oneri':
          'Öneri: 1 kase yulaf lapası (150 kcal), 1 orta boy muz (105 kcal), 1 avuç ceviz (185 kcal), toplam 440 kcal.',
    },
    {
      'aciklama': 'Avokado tost, cherry domates ve roka ile vitamin dolu.',
      'oneri':
          'Öneri: 2 dilim tam buğday ekmeği (140 kcal), 1/2 avokado (160 kcal), cherry domates ve roka (25 kcal), toplam 325 kcal.',
    },
    {
      'aciklama':
          'Peynirli omlet, ıspanak ve mantar ile protein açısından zengin.',
      'oneri':
          'Öneri: 2 adet yumurta (140 kcal), 50g beyaz peynir (125 kcal), ıspanak ve mantar (30 kcal), toplam 295 kcal.',
    },
    {
      'aciklama': 'Yunan usulü yoğurt, bal ve granola ile probiyotik destek.',
      'oneri':
          'Öneri: 200g Yunan yoğurdu (130 kcal), 1 yemek kaşığı bal (64 kcal), 30g granola (120 kcal), toplam 314 kcal.',
    },
    {
      'aciklama': 'Smoothie bowl, çilek, muz ve chia tohumu ile antioksidan.',
      'oneri':
          'Öneri: 1 kase smoothie (180 kcal), 1 yemek kaşığı chia tohumu (60 kcal), taze meyveler (50 kcal), toplam 290 kcal.',
    },
    {
      'aciklama': 'Menemen, tam buğday ekmeği ile Türk usulü lezzet.',
      'oneri':
          'Öneri: 2 adet yumurta (140 kcal), domates, biber (40 kcal), 2 dilim tam buğday ekmeği (140 kcal), toplam 320 kcal.',
    },
    {
      'aciklama': 'Lor peynirli pankek, taze böğürtlen ile hafif ve lezzetli.',
      'oneri':
          'Öneri: 2 adet küçük pankek (200 kcal), 100g lor peyniri (98 kcal), 1 avuç böğürtlen (40 kcal), toplam 338 kcal.',
    },
  ];

  Map<String, dynamic> _mevcutOneri = {};
  String _mevcutAciklama =
      ' Fırında Somon, fırında\n patates, sebze salatası\n(brokoli, karnıbahar, ka-\n bak, patlıcan).';

  @override
  void initState() {
    super.initState();
    _rastgeleOneriGetir();
  }

  void _rastgeleOneriGetir() {
    setState(() {
      _mevcutOneri =
          _kahvaltiOnerileri[_random.nextInt(_kahvaltiOnerileri.length)];
      _mevcutAciklama = _formatAciklama(_mevcutOneri['aciklama']);
    });
  }

  String _formatAciklama(String aciklama) {
    // Uzun metni satırlara böl
    if (aciklama.length > 40) {
      List<String> words = aciklama.split(' ');
      String formatted = '';
      String currentLine = '';

      for (String word in words) {
        if ((currentLine + word).length > 25) {
          formatted += currentLine.trim() + '\n ';
          currentLine = word + ' ';
        } else {
          currentLine += word + ' ';
        }
      }
      formatted += currentLine.trim();
      return ' ' + formatted;
    }
    return ' ' + aciklama;
  }

  Future<void> getAISuggestion() async {
    setState(() {
      loading = true;
      aiSuggestion = "";
    });

    // 2 saniye bekleme (orijinal kodunuzdaki gibi)
    await Future.delayed(const Duration(seconds: 2));

    // ← Burada rastgele öneri alıyoruz
    _rastgeleOneriGetir();

    setState(() {
      aiSuggestion = _mevcutOneri['oneri'] ?? '';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // --- Orijinal Tasarım ---
              Positioned(
                left: 0.01,
                top: 7,
                child: SizedBox(
                  width: 300,
                  height: 101,
                  child: Text(
                    'Kahvaltı',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 65, 117, 38),
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 70,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://www.yerevdekor.com/images_kucuk/f71/duz-duvar-kagidi-siyah-101-51210_13471_1.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              // ← Burada dinamik açıklama gösteriliyor
              Positioned(
                left: 14,
                top: 80,
                child: Text(
                  _mevcutAciklama,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // --- Yapay Zeka Öneri Bölümü ---
              Positioned(
                left: 14,
                bottom: 120,
                right: 14,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF0E6),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Yapay Zeka Destekli Kahvaltı Önerisi:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      loading
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                            aiSuggestion.isEmpty
                                ? "Öneri almak için aşağıdaki butona basın."
                                : aiSuggestion,
                            style: const TextStyle(fontSize: 16),
                          ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loading ? null : getAISuggestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              65,
                              117,
                              38,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            loading ? "Yükleniyor..." : "Öneri Al",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
