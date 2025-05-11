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
          color: Color(0xFFD1DEBD),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(36.5),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF606C38),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSerif',
            ),
          ),
        ),
      ),
    );
  }
}
