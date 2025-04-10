// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String username;

  const ProfileWidget({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/images/profil.png'),
        ),
        const SizedBox(width: 12),
        Text(
          'Hoş geldin, $username',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
