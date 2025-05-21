// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OgleScreen(),
    );
  }
}

class OgleScreen extends StatefulWidget {
  const OgleScreen({super.key});

  @override
  State<OgleScreen> createState() => _OgleScreenState();
}

class _OgleScreenState extends State<OgleScreen> {
  String aiSuggestion = "";
  bool loading = false;
  final Random _random = Random();

  final List<Map<String, dynamic>> _ogleOnerileri = [
    {
      'aciklama': 'Fırında Somon, fırında patates, sebze salatası.',
      'oneri': 'Öneri: 200g fırında somon (400 kcal), 150g fırında patates (200 kcal), sebze salatası (100 kcal), toplam 700 kcal.',
      'besinler': [
        {'isim': 'Sebze salatası', 'gram': '150 gr', 'kalori': '100 kcal', 'aciklama': 'Sebze salatası'},
        {'isim': 'Fırında Somon', 'gram': '200 gr', 'kalori': '400 kcal', 'aciklama': 'Fırında Somon'},
        {'isim': 'Fırında Patates', 'gram': '150 gr', 'kalori': '200 kcal', 'aciklama': 'Fırında Patates'},
      ],
      'protein': '10gr',
      'karbonhidrat': '50gr',
      'yag': '30gr',
      'kalori': '700kcal',
    },
    // Diğer öneriler aynı şekilde...
  ];

  Map<String, dynamic> _mevcutOneri = {};
  String _mevcutAciklama = '';

  @override
  void initState() {
    super.initState();
    _rastgeleOneriGetir();
  }

  void _rastgeleOneriGetir() {
    setState(() {
      _mevcutOneri = _ogleOnerileri[_random.nextInt(_ogleOnerileri.length)];
      _mevcutAciklama = _mevcutOneri['aciklama'];
    });
  }

  Future<void> getAISuggestion() async {
    setState(() {
      loading = true;
      aiSuggestion = "";
    });

    await Future.delayed(const Duration(seconds: 2));
    _rastgeleOneriGetir();

    setState(() {
      aiSuggestion = _mevcutOneri['oneri'] ?? '';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Öğle Yemeği',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: loading ? null : getAISuggestion,
                icon: loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.smart_toy),
                label: Text(loading ? 'AI düşünüyor...' : 'AI Öneri'),
              ),
              const SizedBox(height: 16),
              if (aiSuggestion.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(aiSuggestion),
                ),
              const SizedBox(height: 16),
              Text(_mevcutAciklama, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _degerWidget("Protein", _mevcutOneri['protein'] ?? ''),
                  _degerWidget("Karbonhidrat", _mevcutOneri['karbonhidrat'] ?? ''),
                  _degerWidget("Yağ", _mevcutOneri['yag'] ?? ''),
                  _degerWidget("Kalori", _mevcutOneri['kalori'] ?? ''),
                ],
              ),
              const SizedBox(height: 20),
              ...?_mevcutOneri['besinler']?.map<Widget>((besin) {
                return ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.grey),
                  title: Text("${besin['isim']} - ${besin['gram']}"),
                  subtitle: Text("${besin['aciklama']} - ${besin['kalori']}"),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _degerWidget(String etiket, String deger) {
    return Column(
      children: [
        Text(deger, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(etiket, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}