import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopia1/firebase_service.dart';

class FirebaseService {
  Future<String> registerDb(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'Kayıt başarılı';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Sağlanan şifre çok zayıf.';
      } else if (e.code == 'email-already-in-use') {
        return 'Bu e-posta adresiyle zaten bir hesap var.';
      }
      return e.message ?? 'Bilinmeyen bir hata oluştu';
    }
  }

  Future<String> loginDb(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Giriş başarılı';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Bu e-posta adresiyle kullanıcı bulunamadı.';
      } else if (e.code == 'wrong-password') {
        return 'Yanlış şifre girdiniz.';
      }
      return e.message ?? 'Bilinmeyen bir hata oluştu';
    }
  }
}
