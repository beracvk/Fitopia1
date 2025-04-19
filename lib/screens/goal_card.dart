// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final Color color;
  final String iconAsset;
  
  const GoalCard({
    Key? key,
    required this.title,
    required this.color,
    required this.iconAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = (size.width - 60) / 3.4;
    
    return Container(
      width: cardWidth,
      height: 250,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          
          const Spacer(),
          
          // Icon in the middle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Image.asset(
              iconAsset,
              width: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 70);
              },
            ),
          ),
          
          const Spacer(),
          
          // Progress indicators at bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                _buildProgressIndicator(),
                const SizedBox(height: 5),
                _buildProgressIndicator(),
                const SizedBox(height: 5),
                _buildProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProgressIndicator() {
    return Container(
      width: 90,
      height: 13,
      decoration: BoxDecoration(
        color: const Color.fromARGB(117, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}