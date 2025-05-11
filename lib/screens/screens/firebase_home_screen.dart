import 'package:fitopia2/features/home/presentation/pages/sub_pages/home3_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Home3Screen import edildi

class FirebaseHomeScreen extends StatefulWidget {
  const FirebaseHomeScreen({super.key});

  @override
  FirebaseHomeScreenState createState() => FirebaseHomeScreenState();
}

class FirebaseHomeScreenState extends State<FirebaseHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(_user!.uid).get();
      if (userData.exists && userData.data() != null) {
        setState(() {
          _userData = userData.data() as Map<String, dynamic>;
          _loading = false;
        });

        // Kullanıcı verisi geldikten sonra Home3Screen'e yönlendir
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => HomeScreen(
                  username: _userData?['fullName'] ?? 'Kullanıcı',
                ),
          ),
        );
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            _loading
                ? const CircularProgressIndicator()
                : const Text('Kullanıcı verisi bulunamadı.'),
      ),
    );
  }
}
