// 📄 lib/features/auth/presentation/pages/Sixth_screen.dart
// Güncellenmiş UserInputScreen (kullanıcı bilgilerini kaydeder ve HomeScreen'e gider)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/home3_screen.dart';

class SixthScreen extends StatelessWidget {
  const SixthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserInputScreen();
  }
}

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  UserInputScreenState createState() => UserInputScreenState();
}

class UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController targetWeightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  Future<void> _saveUserInfoAndNavigate() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint("❌ Kullanıcı oturumu yok.");
        return;
      }

      final uid = user.uid;
      final gender = genderController.text.trim().toLowerCase();
      final age = int.tryParse(ageController.text.trim()) ?? 0;
      final height = double.tryParse(heightController.text.trim()) ?? 0.0;
      final weight = double.tryParse(weightController.text.trim()) ?? 0.0;
      final targetWeight =
          double.tryParse(targetWeightController.text.trim()) ?? 0.0;

      final data = {
        'cinsiyet': gender,
        'yas': age,
        'boy': height,
        'kilo': weight,
        'hedefKilo': targetWeight,
        'aktiviteSeviyesi': 'orta',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(data, SetOptions(merge: true));

      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final username = userDoc.data()?['fullName'] ?? 'Kullanıcı';

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(username: username)),
      );
    } catch (e) {
      debugPrint("⚠️ Kullanıcı bilgileri kaydedilemedi: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hata oluştu: $e")));
    }
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    TextInputType type = TextInputType.number,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(152, 255, 255, 255),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      _buildInputField(
                        'Cinsiyetiniz',
                        genderController,
                        type: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      _buildInputField('Yaşınız', ageController),
                      const SizedBox(height: 10),
                      _buildInputField('Boyunuz (cm)', heightController),
                      const SizedBox(height: 10),
                      _buildInputField('Kilonuz (kg)', weightController),
                      const SizedBox(height: 10),
                      _buildInputField(
                        'Hedef Kilonuz (kg)',
                        targetWeightController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveUserInfoAndNavigate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            110,
                            141,
                            80,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'Giriş',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
