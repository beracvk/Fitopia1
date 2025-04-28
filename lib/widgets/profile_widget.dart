import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String username;

  const ProfileWidget({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hoşgeldin, $username!',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
