import 'package:fitopia2/features/home/presentation/pages/sub_pages/deneme_screen.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/goal_card.dart';
import 'package:fitopia2/features/meals/presentations/widgets/action_card.dart';
import 'package:fitopia2/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class Home3Screen extends StatelessWidget {
  final String username;

  const Home3Screen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileWidget(username: username), // Kullanıcı adı buraya geliyor
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
                        MaterialPageRoute(
                          builder: (context) => const DenemeScreen(),
                        ),
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
}
