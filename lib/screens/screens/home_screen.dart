import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopia2/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      setState(() {
        username = doc['username'];
        isLoggedIn = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!isLoggedIn) {
      // 🔹 Giriş yapılmamışsa kullanıcıya butonlar göster
      return Scaffold(
        appBar: AppBar(title: const Text("Hoş Geldiniz")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Devam etmek için giriş yap veya kayıt ol."),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Giriş Yap"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("Kayıt Ol"),
              ),
            ],
          ),
        ),
      );
    }

    // 🔹 Giriş yapılmışsa profil göster
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileWidget(username: username ?? 'Kullanıcı'),
              const SizedBox(height: 50),

              // ... Diğer kartlar ve içerikler
            ],
          ),
        ),
      ),
    );
  }
}
