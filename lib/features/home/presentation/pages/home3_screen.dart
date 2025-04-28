// ignore_for_file: unused_import, non_constant_identifier_names, use_super_parameters

import 'package:fitopia2/features/home/presentation/pages/sub_pages/deneme_screen.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/profile_widget.dart';
import 'sub_pages/goal_card.dart';
import '../../../../widgets/action_card.dart';
import '../../../meals/presentations/widgets/action_card.dart' show ActionCard;
import '../../../../screens/diyet_plan_page.dart';
import 'sub_pages/diyetplani.dart';
//import 'sub_pages/goal_card.dart' show GoalCard;
import 'sub_pages/porsiyon_sayfasi.dart';
import '../../../../screens/egzersiz_planim.dart';
import 'sub_pages/motivasyon_page.dart';
// ignore: undefined_shown_name
import 'package:fitopia2/widgets/profile_widget.dart' show ProfileWidget;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileWidget(username: 'Bera'),
              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoalCard(
                    title: 'HEDEF/2.5 Litre',
                    color: const Color.fromARGB(66, 1, 66, 119),
                    iconAsset: 'assets/images/su.webp',
                  ),
                  GoalCard(
                    title: 'HEDEF/2000 Kalori',
                    color: const Color.fromARGB(167, 212, 31, 18),
                    iconAsset: 'assets/images/alev5.webp',
                  ),
                  GoalCard(
                    title: 'HEDEF 10 000 Adım',
                    color: const Color.fromARGB(89, 211, 190, 7),
                    iconAsset: 'assets/images/koşu5.webp',
                  ),
                ],
              ),

              const SizedBox(height: 60),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionCard(
                    title: 'Diyet Planı',
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
                        MaterialPageRoute(
                          builder: (context) => const DenemeScreen(),
                        ),
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
                          builder: (context) => const DenemeScreen(),
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

  ProfileWidget({required String username}) {}
}
