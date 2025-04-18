// ignore_for_file: file_names, library_private_types_in_public_api, camel_case_types, unused_import, depend_on_referenced_packages


import 'package:fitopia2/screens/Fourth_screen.dart';
import 'package:fitopia2/screens/Home2-screen.dart';
import 'package:fitopia2/screens/seventh_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/screens/eighth_screen.dart'; // Eğer kullanılıyorsa


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
  final String correctEmail = "ravzakas5@gmail.com";
  final String correctPassword = "123456";

  // Giriş doğrulama
  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_emailController.text == correctEmail &&
          _passwordController.text == correctPassword) {
        // Doğru giriş yapıldığında HomeScreen'e yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FifthScreen()),
        );
      } else {
        // Yanlış girişte hata mesajı göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hatalı e-posta veya şifre!")),
        );
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
                    fontFamily: "Courgette-Regular",
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
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EighthScreen(),));
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
                    padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
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
                    const Text("Hesabın mı yok?",
                        style: TextStyle(color: Colors.green, fontSize: 18.0)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SeventhScreen(),));
                      },
                      child: const Text("Hesap aç",
                          style: TextStyle(color: Colors.red, fontSize: 18.0)),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text("Hesabınla Devam Et",
                    style: TextStyle(color: Colors.green, fontSize: 18.0)),
                const SizedBox(height: 30),
                // Google ile giriş
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(62, 173, 245, 153),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    // Google ile giriş işlemi
                  },
                  child: const Text("GOOGLE", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
