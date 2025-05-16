// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

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

  Future<void> getAISuggestion() async {
    setState(() {
      loading = true;
      aiSuggestion = "";
    });

    // Burada Gemini API çağrısı yapılacak (simülasyon için delay koyuyoruz)
    await Future.delayed(const Duration(seconds: 2));

    // Örnek cevap (bunu Gemini API'den dönen gerçek yanıtla değiştir)
    const sampleResponse =
        "Öneri: 2 dilim tam buğday ekmeği (140 kcal), 1 adet haşlanmış yumurta (70 kcal), 1 porsiyon sebze salatası (50 kcal), toplam 260 kcal.";

    setState(() {
      aiSuggestion = sampleResponse;
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
              Positioned(
                left: 14,
                top: 80,
                child: Text(
                  ' Fırında Somon, fırında\n patates, sebze salatası\n(brokoli, karnıbahar, ka-\n bak, patlıcan).',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // ... diğer Positioned widget'lar aynen devam ediyor ...

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

              // Eğer tasarımda sabit alan yetmiyorsa, yukarıdaki widget'ların
              // konumlarını hafif değiştirmek gerekebilir. Ama önce bu haliyle deneyelim.
            ],
          ),
        ),
      ),
    );
  }
}
