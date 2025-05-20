// ignore_for_file: unused_import, non_constant_identifier_names, use_super_parameters

import 'dart:ui';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/yesil9.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hoş geldin + profil
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DenemeScreen()),
                        );
                      },
                      child: const Icon(Icons.account_circle, size: 40),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Hoş geldin $username!',
                        style: const TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // Hedef kartları
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: GoalCard(
                        title: 'HEDEF\n2.5 Litre',
                        icon: Icons.water_drop,
                        color: Color.fromARGB(225, 123, 207, 252),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: GoalCard(
                        title: 'HEDEF\n2000 Kalori',
                        icon: Icons.local_fire_department,
                        color: Color.fromARGB(171, 243, 5, 5),
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: GoalCard(
                        title: 'HEDEF\n10 000 Adım',
                        icon: Icons.directions_walk,
                        color: Color.fromARGB(181, 247, 240, 144),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // Yönlendirmeli butonlar - İlk koddaki navigasyonlar ile güncellendi
                FrostedActionButton(
                  title: 'Beslenme\nPlanı',
                  backgroundColor: const Color.fromARGB(175, 255, 255, 255),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Diyetplani()),
                    );
                  },
                ),
                const SizedBox(height: 35),
                FrostedActionButton(
                  title: 'Egzersiz\nPlanı',
                  backgroundColor: const Color.fromARGB(175, 255, 255, 255),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FigmaToCodeApp()),
                    );
                  },
                ),
                const SizedBox(height: 35),
                FrostedActionButton(
                  title: 'Porsiyon\nAnalizi',
                  backgroundColor: const Color.fromARGB(155, 255, 255, 255),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FigmaToCodeApp2()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const GoalCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final lines = title.split('\n');
    final firstLine = lines[0]; // "HEDEF"
    final secondLine = lines.length > 1 ? lines[1] : '';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Icon(icon, size: 43),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$firstLine\n',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,  // Kalın
                    fontSize: 18,
                    color: Colors.black87,        // Koyu gri
                  ),
                ),
                TextSpan(
                  text: secondLine,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,  // İnce
                    fontSize: 17,
                    color: Color.fromARGB(230, 0, 0, 0), // Daha koyu gri
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FrostedActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;

  const FrostedActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor = const Color.fromARGB(83, 148, 148, 148),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color.fromARGB(58, 41, 31, 31), width: 1),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}