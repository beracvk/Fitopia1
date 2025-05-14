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
import '../../../../../screens/egzersiz_planim.dart';
import 'motivasyon_page.dart';
// ignore: undefined_shown_name
import 'package:fitopia2/widgets/profile_widget.dart' show ProfileWidget;

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileWidget(username: username),
              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoalCard(
                    title: 'HEDEF/2.5 Litre',
                    color: Color(0xFFBAD7DF),
                    iconAsset: 'assets/images/su.webp',
                  ),
                  GoalCard(
                    title: 'HEDEF/2000 Kalori',
                    color:  Color(0xFFF34336),
                    iconAsset: 'assets/images/alev5.webp',
                  ),
                  GoalCard(
                    title: 'HEDEF 10 000 Adım',
                    color: Color(0xFFFFD95F),
                    iconAsset: 'assets/images/koşu5.webp',
                  ),
                ],
              ),

              const SizedBox(height: 80),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionCard(
                    title: 'Beslenme Planı',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Diyetplani()),
                      );
                    },
                  ),
                  ActionCard(
                    title: 'Porsiyon Analizi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FigmaToCodeApp3()),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionCard(
                    title: 'Egzersiz Planı',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FigmaToCodeApp(),
                        ),
                      );
                    },
                  ),
                  ActionCard(
                    title: 'Motive Mesaj',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DenemeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
