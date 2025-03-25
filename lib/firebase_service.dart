import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User Registration Method
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

  // Register Database (Simulated example)
  Future<String> registerDb(String email, String password) async {
    // Bu metod örnek olarak eklenmiştir, Firebase DB işlemleri buraya eklenecektir.
    try {
      // Firebase DB işlemleri yapılabilir. Burada bir örnek olası kullanım.
      await Future.delayed(Duration(seconds: 2)); // Simulate DB interaction
      return 'Veritabanı kaydı başarılı';
    } catch (e) {
      return 'Veritabanı kaydında hata oluştu: $e';
    }
  }
}
