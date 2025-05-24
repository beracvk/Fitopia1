// ignore_for_file: file_names, library_private_types_in_public_api, camel_case_types, unused_import, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopia2/features/onboarding/presentation/pages/Fourth_screen.dart';
import 'package:fitopia2/features/auth/presentation/pages/Seventh_screen.dart';
import 'package:fitopia2/features/auth/presentation/pages/Eighth_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/auth/presentation/pages/Sixth_screen.dart'; // Eğer kullanılıyorsa
import 'package:fitopia2/services/auth_service.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/home3_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitopia2/features/home/presentation/pages/sub_pages/fifth_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Giriş için email ve şifre kontrolü
  bool _obscureText = true;

  // Doğru e-posta ve şifre
  //final String correctEmail = "ravzakas5@gmail.com";
  //final String correctPassword = "123456";

  // Giriş doğrulama
void _login() async {
  if (_formKey.currentState!.validate()) {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      if (!mounted) return;

      final userId = userCredential.user!.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final username = userDoc.data()?['fullName'] ?? 'Kullanıcı';

      if (!mounted) return;

      // 🔥 BURASI ÖNEMLİ: required 'username' parametresi gönderiliyor
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SixthScreen(username: username),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Kullanıcı bulunamadı.';
          break;
        case 'wrong-password':
          message = 'Hatalı şifre.';
          break;
        case 'invalid-email':
          message = 'Geçersiz e-posta adresi.';
          break;
        case 'network-request-failed':
          message = 'İnternet bağlantısı yok.';
          break;
        default:
          message = 'Giriş yapılamadı. Hata: ${e.message}';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset('assets/images/fitopia.jpg', width: 200),
                const SizedBox(height: 70),
                // Başlık
                Text(
                  "Hesabına Giriş Yap",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 110, 141, 80),
                  ),
                ),
                const SizedBox(height: 20),
                // E-posta TextField
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    hintText: "E-posta adresi...",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 141, 80),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-posta adresini girin.';
                    } else if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value)) {
                      return 'Geçerli bir e-posta adresi girin.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Şifre TextField
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    hintText: "Şifre...",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color.fromARGB(255, 110, 141, 80),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifrenizi girin.';
                    } else if (value.length < 6) {
                      return 'Şifre en az 6 karakter olmalıdır.';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EighthScreen()),
                      );
                    },
                    child: const Text(
                      "Şifreni mi unuttun?",
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                    ),
                  ),
                ),
                // Giriş Butonu
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 110, 141, 80),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 15,
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    "Giriş",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
                const SizedBox(height: 20),
                // Hesap açma bağlantısı
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hesabın mı yok?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 110, 141, 80),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThirdScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Çıkış yap",
                        style: TextStyle(color: Colors.red, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  "Hesabınla Devam Et",
                  style: TextStyle(color: Color.fromARGB(255, 110, 141, 80)),
                ),
                const SizedBox(height: 30),
                // Google ile giriş
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(62, 173, 245, 153),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    // Google ile giriş işlemi
                  },
                  child: const Text(
                    "GOOGLE",
                    style: TextStyle(color: Colors.red),
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
