import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final Color color;
  final String iconAsset;

  const GoalCard({
    super.key,
    required this.title,
    required this.color,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Genişlik ayarı
      height: 120, // Yükseklik ayarı
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconAsset, width: 40), // İkon resmi
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}