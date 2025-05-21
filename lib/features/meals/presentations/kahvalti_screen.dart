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
      'malzemeler': [
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140},
        {'ad': 'Haşlanmış yumurta', 'miktar': '1 adet', 'kalori': 70},
        {'ad': 'Sebze salatası', 'miktar': '1 porsiyon', 'kalori': 50},
      ],
      'toplamKalori': 260,
    },
    {
      'aciklama':
          'Yulaf lapası, taze meyveler ve cevizle besleyici bir başlangıç.',
      'malzemeler': [
        {'ad': 'Yulaf lapası', 'miktar': '1 kase', 'kalori': 150},
        {'ad': 'Muz', 'miktar': '1 orta boy', 'kalori': 105},
        {'ad': 'Ceviz', 'miktar': '1 avuç', 'kalori': 185},
      ],
      'toplamKalori': 440,
    },
    {
      'aciklama': 'Avokado tost, cherry domates ve roka ile vitamin dolu.',
      'malzemeler': [
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140},
        {'ad': 'Avokado', 'miktar': '1/2 adet', 'kalori': 160},
        {'ad': 'Cherry domates ve roka', 'miktar': '1 porsiyon', 'kalori': 25},
      ],
      'toplamKalori': 325,
    },
    {
      'aciklama':
          'Peynirli omlet, ıspanak ve mantar ile protein açısından zengin.',
      'malzemeler': [
        {'ad': 'Yumurta', 'miktar': '2 adet', 'kalori': 140},
        {'ad': 'Beyaz peynir', 'miktar': '50g', 'kalori': 125},
        {'ad': 'Ispanak ve mantar', 'miktar': '1 porsiyon', 'kalori': 30},
      ],
      'toplamKalori': 295,
    },
    {
      'aciklama': 'Yunan usulü yoğurt, bal ve granola ile probiyotik destek.',
      'malzemeler': [
        {'ad': 'Yunan yoğurdu', 'miktar': '200g', 'kalori': 130},
        {'ad': 'Bal', 'miktar': '1 yemek kaşığı', 'kalori': 64},
        {'ad': 'Granola', 'miktar': '30g', 'kalori': 120},
      ],
      'toplamKalori': 314,
    },
    {
      'aciklama': 'Smoothie bowl, çilek, muz ve chia tohumu ile antioksidan.',
      'malzemeler': [
        {'ad': 'Smoothie', 'miktar': '1 kase', 'kalori': 180},
        {'ad': 'Chia tohumu', 'miktar': '1 yemek kaşığı', 'kalori': 60},
        {'ad': 'Taze meyveler', 'miktar': '1 porsiyon', 'kalori': 50},
      ],
      'toplamKalori': 290,
    },
    {
      'aciklama': 'Menemen, tam buğday ekmeği ile Türk usulü lezzet.',
      'malzemeler': [
        {'ad': 'Yumurta', 'miktar': '2 adet', 'kalori': 140},
        {'ad': 'Domates ve biber', 'miktar': '1 porsiyon', 'kalori': 40},
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140},
      ],
      'toplamKalori': 320,
    },
    {
      'aciklama': 'Lor peynirli pankek, taze böğürtlen ile hafif ve lezzetli.',
      'malzemeler': [
        {'ad': 'Küçük pankek', 'miktar': '2 adet', 'kalori': 200},
        {'ad': 'Lor peyniri', 'miktar': '100g', 'kalori': 98},
        {'ad': 'Böğürtlen', 'miktar': '1 avuç', 'kalori': 40},
      ],
      'toplamKalori': 338,
    },
    {
      'aciklama':
          'Chia tohumu pudingi, hindistan cevizi ve mango ile tropikal.',
      'malzemeler': [
        {'ad': 'Chia tohumu', 'miktar': '2 yemek kaşığı', 'kalori': 120},
        {'ad': 'Hindistan cevizi sütü', 'miktar': '200ml', 'kalori': 90},
        {'ad': 'Mango dilimi', 'miktar': '1 porsiyon', 'kalori': 80},
      ],
      'toplamKalori': 290,
    },
    {
      'aciklama': 'Fıstık ezmeli tost, muz dilimleri ve bal ile enerji verici.',
      'malzemeler': [
        {'ad': 'Tam buğday ekmeği', 'miktar': '2 dilim', 'kalori': 140},
        {'ad': 'Fıstık ezmesi', 'miktar': '2 yemek kaşığı', 'kalori': 190},
        {'ad': 'Küçük muz', 'miktar': '1 adet', 'kalori': 90},
      ],
      'toplamKalori': 420,
    },
    {
      'aciklama':
          'Türk kahvaltısı tabağı, peynir, zeytin, domates ve salatalık.',
      'malzemeler': [
        {'ad': 'Beyaz peynir', 'miktar': '60g', 'kalori': 150},
        {'ad': 'Siyah zeytin', 'miktar': '10 adet', 'kalori': 50},
        {'ad': 'Domates-salatalık', 'miktar': '1 porsiyon', 'kalori': 30},
        {'ad': 'Ekmek', 'miktar': '1 dilim', 'kalori': 70},
      ],
      'toplamKalori': 300,
    },
    {
      'aciklama':
          'Acai bowl, granola, hindistan cevizi ve çilek ile süper gıda.',
      'malzemeler': [
        {'ad': 'Acai püresi', 'miktar': '100g', 'kalori': 70},
        {'ad': 'Granola', 'miktar': '30g', 'kalori': 120},
        {'ad': 'Hindistan cevizi', 'miktar': '1 porsiyon', 'kalori': 40},
        {'ad': 'Çilek', 'miktar': '1 porsiyon', 'kalori': 30},
      ],
      'toplamKalori': 260,
    },
    {
      'aciklama': 'Quinoa tabağı, haşlanmış yumurta ve avokado ile protein.',
      'malzemeler': [
        {'ad': 'Pişmiş quinoa', 'miktar': '1/2 kase', 'kalori': 110},
        {'ad': 'Haşlanmış yumurta', 'miktar': '1 adet', 'kalori': 70},
        {'ad': 'Avokado', 'miktar': '1/4 adet', 'kalori': 80},
      ],
      'toplamKalori': 260,
    },
    {
      'aciklama': 'Somon füme, labne peyniri ve dereotu ile lüks başlangıç.',
      'malzemeler': [
        {'ad': 'Somon füme', 'miktar': '50g', 'kalori': 120},
        {'ad': 'Labne', 'miktar': '100g', 'kalori': 80},
        {'ad': 'Çavdar ekmeği', 'miktar': '1 dilim', 'kalori': 90},
      ],
      'toplamKalori': 290,
    },
    {
      'aciklama': 'Vegan tofu scramble, nutritional yeast ve sebzeler ile.',
      'malzemeler': [
        {'ad': 'Tofu', 'miktar': '100g', 'kalori': 80},
        {'ad': 'Nutritional yeast', 'miktar': '1 porsiyon', 'kalori': 20},
        {'ad': 'Karışık sebze', 'miktar': '1 porsiyon', 'kalori': 40},
        {'ad': 'Tam buğday ekmeği', 'miktar': '1 dilim', 'kalori': 70},
      ],
      'toplamKalori': 210,
    },
    {
      'aciklama': 'Keto kahvaltısı, scrambled egg, bacon ve avokado ile.',
      'malzemeler': [
        {'ad': 'Yumurta', 'miktar': '2 adet', 'kalori': 140},
        {'ad': 'Bacon', 'miktar': '2 dilim', 'kalori': 86},
        {'ad': 'Avokado', 'miktar': '1/2 adet', 'kalori': 160},
        {'ad': 'Çedar peyniri', 'miktar': '30g', 'kalori': 113},
      ],
      'toplamKalori': 499,
    },
    {
      'aciklama': 'Overnight oats, vanilyalı protein tozu ve meyveler ile.',
      'malzemeler': [
        {'ad': 'Yulaf', 'miktar': '40g', 'kalori': 150},
        {'ad': 'Protein tozu', 'miktar': '1 ölçek', 'kalori': 120},
        {'ad': 'Badem sütü', 'miktar': '200ml', 'kalori': 60},
        {'ad': 'Meyveler', 'miktar': '1 porsiyon', 'kalori': 50},
      ],
      'toplamKalori': 380,
    },
    {
      'aciklama': 'Ricotta peynirli krep, bal ve ceviz ile İtalyan usulü.',
      'malzemeler': [
        {'ad': 'İnce krep', 'miktar': '2 adet', 'kalori': 160},
        {'ad': 'Ricotta', 'miktar': '100g', 'kalori': 174},
        {'ad': 'Bal', 'miktar': '1 tatlı kaşığı', 'kalori': 21},
        {'ad': 'Ceviz', 'miktar': '1 porsiyon', 'kalori': 50},
      ],
      'toplamKalori': 405,
    },
    {
      'aciklama':
          'Green smoothie, ıspanak, elma, muz ve chia tohumu ile detoks.',
      'malzemeler': [
        {'ad': 'Ispanak', 'miktar': '1 avuç', 'kalori': 7},
        {'ad': 'Elma', 'miktar': '1 adet', 'kalori': 80},
        {'ad': 'Muz', 'miktar': '1/2 adet', 'kalori': 50},
        {'ad': 'Chia tohumu', 'miktar': '1 porsiyon', 'kalori': 60},
      ],
      'toplamKalori': 197,
    },
    {
      'aciklama':
          'Benedict eggs, İngiliz çöreği üzerinde poached egg ve hollandaise.',
      'malzemeler': [
        {'ad': 'İngiliz çöreği', 'miktar': '1 adet', 'kalori': 140},
        {'ad': 'Poached egg', 'miktar': '2 adet', 'kalori': 140},
        {'ad': 'Hollandaise sos', 'miktar': '1 porsiyon', 'kalori': 100},
      ],
      'toplamKalori': 380,
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
      aiSuggestion = _buildMalzemelerListesi();
      loading = false;
    });
  }

  String _buildMalzemelerListesi() {
    if (_mevcutOneri.isEmpty) return '';

    String liste = '';
    List<dynamic> malzemeler = _mevcutOneri['malzemeler'] ?? [];

    for (var malzeme in malzemeler) {
      liste +=
          '• ${malzeme['ad']} (${malzeme['miktar']}) - ${malzeme['kalori']} kcal\n';
    }

    liste += '\nToplam: ${_mevcutOneri['toplamKalori']} kcal';

    return liste;
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
                          : Container(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: SingleChildScrollView(
                              child: Text(
                                aiSuggestion.isEmpty
                                    ? "Öneri almak için aşağıdaki butona basın."
                                    : aiSuggestion,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),
                            ),
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
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
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
