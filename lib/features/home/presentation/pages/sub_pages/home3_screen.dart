// ignore_for_file: unused_import, non_constant_identifier_names, use_super_parameters

import 'package:fitopia2/features/home/presentation/pages/sub_pages/deneme_screen.dart';
import 'package:fitopia2/features/meals/presentations/Ogle_screen.dart';
import 'package:fitopia2/screens/porsiyon_analizi_page.dart';
import 'package:flutter/material.dart';
import '../../../../../widgets/profile_widget.dart';
import 'goal_card.dart';
import '../../../../../widgets/action_card.dart';
import '../../../../meals/presentations/widgets/action_card.dart'
    show ActionCard;
import 'diyetplani.dart';
//import 'sub_pages/goal_card.dart' show GoalCard;
import 'porsiyon_sayfasi.dart';
import 'egzersiz_planim.dart';
import 'motivasyon_page.dart';
// ignore: undefined_shown_name
import 'package:fitopia2/widgets/profile_widget.dart' show ProfileWidget;

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // klavye açıldığında layout bozulmasın
      body: Stack(
        children: [
          // 🌄 Arka plan görseli

          // 🟫 Saydam karartma katmanı
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(77, 0, 0, 0), // %30 siyah
            ),
          ),

          // 📦 İçerik alanı
          SafeArea(
            bottom: false, // 🔥 Alt boşluk bırakmasın
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ProfileWidget(username: username),
                      const SizedBox(height: 20),

                      // 🎯 Hedef kartları
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: GlassCard(
                              child: GoalCard(
                                title: '2.5 Litre Su',
                                color: const Color(0xFF81D4FA),
                                iconAsset: 'assets/images/su.webp',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: GlassCard(
                              child: GoalCard(
                                title: '2000 Kalori',
                                color: const Color.fromARGB(255, 245, 104, 85),
                                iconAsset: 'assets/images/alev5.webp',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: GlassCard(
                              child: GoalCard(
                                title: '10.000 Adım',
                                color: const Color(0xFFFFF59D),
                                iconAsset: 'assets/images/koşu5.webp',
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // 🍽️ Aksiyon kartları - 1
                      Row(
                        children: [
                          Expanded(
                            child: GlassCard(
                              child: ActionCard(
                                title: 'Beslenme Planı',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Diyetplani(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GlassCard(
                              child: ActionCard(
                                title: 'Porsiyon Analizi',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FigmaToCodeApp2(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // 🏃 Aksiyon kartları - 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width *
                                0.45, // üstteki kutularla aynı genişlik
                            child: GlassCard(
                              child: ActionCard(
                                title: 'Egzersiz Planı',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const FigmaToCodeApp(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 💠 Saydam kart widget'ı
class GlassCard extends StatelessWidget {
  final Widget child;

  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(150, 255, 255, 255), // %60 saydam beyaz
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(60, 0, 0, 0),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(8.0), child: child),
    );
  }
}
