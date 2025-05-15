import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String username;

  const ProfileWidget({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedName = username.isNotEmpty
        ? username[0].toUpperCase() + username.substring(1)
        : 'Kullanıcı';

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person, // İkon burada (dilersen değiştir: Icons.face, Icons.star vb.)
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 8), // İkonla yazı arası boşluk
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Hoş Geldin ',
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: "SourceSerif",
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: formattedName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'SourceSerif',
                        shadows: [
                          Shadow(
                            offset: Offset(1, 2),
                            blurRadius: 3,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                    const TextSpan(
                      text: ' !',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
