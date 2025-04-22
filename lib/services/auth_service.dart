import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

final logger = Logger();

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

      logger.i("Kullanıcı başarıyla kaydedildi: ${user.uid}");
      return user;
    } catch (e) {
      logger.e("Kayıt sırasında hata oluştu: $e");
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

      logger.i("Kullanıcı giriş yaptı: ${userCredential.user?.uid}");
      return userCredential.user;
    } catch (e) {
      logger.e("Giriş sırasında hata oluştu: $e");
      return null;
    }
  }

  // Kullanıcı Bilgilerini Firestore'dan Getirme
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        logger.i("Kullanıcı verisi bulundu: ${doc.data()}");
        return doc.data() as Map<String, dynamic>;
      } else {
        logger.w("Kullanıcı verisi bulunamadı: $userId");
        return null;
      }
    } catch (e) {
      logger.e("Veri getirme sırasında hata oluştu: $e");
      return null;
    }
  }
    Future<void> signOut() async {
    await _auth.signOut();
  }
}