import 'package:flutter/material.dart';

class DenemeScreen extends StatelessWidget {
  const DenemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deneme Ekranı'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text('Burası Deneme Sayfası', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
