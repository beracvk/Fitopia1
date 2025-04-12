// ignore_for_file: library_private_types_in_public_api, duplicate_import, depend_on_referenced_packages, file_names

import 'package:fitopia2/screens/Fourth_screen.dart';
import 'package:fitopia2/screens/Home2-screen.dart';
import 'package:flutter/material.dart';


class SeventhScreen extends StatelessWidget {
  const SeventhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _passwordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Kullanıcı adı, e-posta ve şifre doğrulaması
  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Eğer doğrulama başarılıysa, doğru bilgileri giren kullanıcıyı HomeScreen'e yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FifthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset('assets/images/fitopia.jpg', width: 200),
                  const SizedBox(height: 50),
                  Text(
                    "Hesap Oluşturun",
                    style: TextStyle(
                      fontFamily: "Courgette-Regular",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 110, 141, 80),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Kullanıcı Adı TextField
                  _buildTextField(
                    controller: _usernameController,
                    icon: Icons.person_outline,
                    hintText: "Kullanıcı Adı",
                    isPassword: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kullanıcı adı girin.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // E-posta veya Telefon TextField
                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    hintText: "E-posta Adres veya Telefon No",
                    isPassword: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-posta adresi girin.';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Geçerli bir e-posta adresi girin.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Şifre TextField
                  _buildTextField(
                    controller: _passwordController,
                    icon: Icons.lock_outline,
                    hintText: "Şifre...",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre girin.';
                      } else if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalıdır.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Hesap Aç Butonu
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 110, 141, 80),
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _signUp, // Doğru bilgilerle giriş yapıldığında yönlendirme
                    child: const Text(
                      "Hesap Aç",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 70),

                  // Hesabınla Devam Et
                  const Text(
                    "Hesabınla Devam Et",
                    style: TextStyle(color: Color.fromARGB(255, 110, 141, 80), fontSize: 16),
                  ),
                  const SizedBox(height: 30),

                  // Google Butonu
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(62, 173, 245, 153),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
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
      ),
    );
  }

  // Özel TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required bool isPassword,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !_passwordVisible : false,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF6E8D50),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
      style: const TextStyle(color: Colors.white),
      validator: validator,
    );
  }
}
