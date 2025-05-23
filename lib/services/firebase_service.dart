import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get auth => null;

  // 🔐 Kullanıcı Kaydı
  Future<String> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Kayıt başarılı';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Bu e-posta adresi zaten kullanımda.';
        case 'weak-password':
          return 'Şifre en az 6 karakter olmalıdır.';
        case 'invalid-email':
          return 'Geçersiz e-posta adresi.';
        default:
          return 'Bilinmeyen bir hata oluştu: ${e.message}';
      }
    } catch (e) {
      return 'Bir hata oluştu: $e';
    }
  }

  // 🔄 Örnek veritabanı kaydı (simülasyon)
  Future<String> registerDb(String email, String password) async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simülasyon
      return 'Veritabanı kaydı başarılı';
    } catch (e) {
      return 'Veritabanı kaydında hata oluştu: $e';
    }
  }

  // 🔍 Firestore'dan kullanıcı tercihlerini alma
  Future<Map<String, dynamic>?> getUserPreferences(String userId) async {
    try {
      final docSnapshot =
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('preferences')
              .doc('main')
              .get();

      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Hata: $e');
      return null;
    }
  }
}
