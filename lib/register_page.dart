import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fitopia2/features/auth/presentation/login_screen.dart'; // LoginPage ekranını ekle

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController =
      TextEditingController(); // 🔹 Ad soyad
  final TextEditingController _usernameController =
      TextEditingController(); // 🔹 Kullanıcı adı
  String _errorMessage = '';

  bool isValidEmail(String email) {
    RegExp regExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regExp.hasMatch(email);
  }

  void _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      String userId = userCredential.user!.uid;

      // 🔹 Firestore’a kullanıcı bilgilerini kaydet
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': _emailController.text.trim(),
        'fullName': _fullNameController.text.trim(),
        'username': _usernameController.text.trim(),
        'createdAt': DateTime.now(),
      });

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Bir hata oluştu';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Bir hata oluştu';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Ad Soyad'),
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-posta'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Şifre'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Kayıt Ol'),
              ),
              const SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
