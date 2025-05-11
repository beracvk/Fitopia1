import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String username;

  const ProfileWidget({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedName = username.isNotEmpty
        ? username[0].toUpperCase() + username.substring(1)
        : 'Kullanıcı';

    return Text.rich(
      TextSpan(
        text: 'Hoşgeldin, ',
        style: const TextStyle(fontSize: 24, color: Colors.black54),
        
        children: [
          TextSpan(
            text: formattedName,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6E8D50),
              fontFamily: 'SourceSerif',
              shadows: [
                Shadow(
                  offset: Offset(1, 2),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
          const TextSpan(text: '!'),
        ],
      ),
    );
  }
}