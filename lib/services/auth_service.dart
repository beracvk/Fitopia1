import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcı Kaydı
  Future<User?> registerUser(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // Kullanıcı Firestore’a ekleniyor
      await _firestore.collection('users').doc(user!.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': DateTime.now(),
      });

      return user;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  // Kullanıcı Girişi
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  // Kullanıcı Bilgilerini Firestore'dan Getirme
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }
}
