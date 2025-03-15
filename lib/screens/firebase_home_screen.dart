import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      if (userData.exists) {
        setState(() {
          _userData = userData.data() as Map<String, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ana Sayfa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: Center(
        child:
            _userData == null
                ? const CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ad: ${_userData!['fullName']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Email: ${_userData!['email']}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
      ),
    );
  }
}
