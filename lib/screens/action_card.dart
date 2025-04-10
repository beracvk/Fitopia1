// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ActionCard({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = (size.width - 55) / 2;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: cardWidth,
        height: 178,
        decoration: BoxDecoration(
          color: const Color.fromARGB(85, 22, 81, 24),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(36.5),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 18, 110, 19),
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
