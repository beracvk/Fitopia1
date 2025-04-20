import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginPage({super.key});

    void _addUser() {
    firestore.collection('users').add({
      'name': 'Bera',
      'email': 'bera@example.com',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addUser();
                // Giriş işlemleri burada yapılabilir
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
