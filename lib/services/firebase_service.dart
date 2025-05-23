import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Auth getter'ı düzeltildi
  FirebaseAuth get auth => _auth;

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

  // 🔍 Firestore'dan kullanıcı tercihlerini alma (preferences koleksiyonu için)
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
        // Eğer preferences yoksa ana users koleksiyonundan dene
        return await getUserData();
      }
    } catch (e) {
      print('Preferences alma hatası: $e');
      return null;
    }
  }

  // ✅ Kullanıcının temel bilgilerini al (ana users koleksiyonundan)
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('Kullanıcı verisi alma hatası: $e');
      return null;
    }
  }

  // ✅ Kullanıcı verilerini güncelle
  Future<bool> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Kullanıcı verileri güncellenemedi: $e');
      return false;
    }
  }

  // ✅ İlk kayıt sırasında kullanıcı bilgilerini kaydet
  Future<bool> saveUserProfile({
    required String userId,
    required String name,
    required double boy,
    required double kilo,
    required int yas,
    required String cinsiyet,
    String? hedef,
    String? aktiviteSeviyesi,
  }) async {
    try {
      Map<String, dynamic> userData = {
        'name': name,
        'boy': boy,
        'kilo': kilo,
        'yas': yas,
        'cinsiyet': cinsiyet,
        'hedef': hedef ?? 'koruma',
        'aktiviteSeviyesi': aktiviteSeviyesi ?? 'orta',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('users')
          .doc(userId)
          .set(userData, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('Kullanıcı profili kaydedilemedi: $e');
      return false;
    }
  }

  // ✅ Su, kalori ve adım hedeflerini hesapla (geliştirilmiş versiyon)
  Future<Map<String, dynamic>?> calculateGoals() async {
    final userData = await getUserData();
    if (userData == null) return null;

    final kilo = (userData['kilo'] as num?)?.toDouble() ?? 70.0;
    final boy = (userData['boy'] as num?)?.toDouble() ?? 170.0;
    final yas = (userData['yas'] as num?)?.toInt() ?? 30;
    final cinsiyet =
        (userData['cinsiyet'] as String?)?.toLowerCase() ?? 'erkek';
    final hedef = userData['hedef'] as String? ?? 'koruma';
    final aktiviteSeviyesi = userData['aktiviteSeviyesi'] as String? ?? 'orta';

    // Su hesaplama (geliştirilmiş)
    double suMiktari = kilo * 35; // ml cinsinden
    switch (aktiviteSeviyesi) {
      case 'düşük':
        suMiktari *= 1.0;
        break;
      case 'orta':
        suMiktari *= 1.2;
        break;
      case 'yüksek':
        suMiktari *= 1.5;
        break;
    }
    double su = suMiktari / 1000; // Litre cinsinden

    // Kalori hesaplama (BMR + aktivite)
    double bmr;
    if (cinsiyet == 'erkek') {
      bmr = 88.362 + (13.397 * kilo) + (4.799 * boy) - (5.677 * yas);
    } else {
      bmr = 447.593 + (9.247 * kilo) + (3.098 * boy) - (4.330 * yas);
    }

    double gunlukKalori = bmr * 1.375; // Hafif aktif yaşam tarzı

    // Hedefe göre kalori ayarlama
    switch (hedef) {
      case 'verme':
        gunlukKalori -= 500;
        break;
      case 'alma':
        gunlukKalori += 500;
        break;
      case 'koruma':
      default:
        break;
    }

    // Adım hedefi yaşa göre
    int adim;
    if (yas < 18) {
      adim = 12000;
    } else if (yas <= 30) {
      adim = 10000;
    } else if (yas <= 50) {
      adim = 8000;
    } else if (yas <= 65) {
      adim = 6000;
    } else {
      adim = 4000;
    }

    return {'su': su, 'kalori': gunlukKalori.round(), 'adim': adim};
  }

  // ✅ Günlük takip verilerini kaydet (opsiyonel - ileride kullanım için)
  Future<bool> saveDailyProgress({
    required String userId,
    required String date, // YYYY-MM-DD formatında
    double? suMiktari,
    int? kaloriAlimi,
    int? adimSayisi,
  }) async {
    try {
      Map<String, dynamic> progressData = {
        'date': date,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (suMiktari != null) progressData['su'] = suMiktari;
      if (kaloriAlimi != null) progressData['kalori'] = kaloriAlimi;
      if (adimSayisi != null) progressData['adim'] = adimSayisi;

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('daily_progress')
          .doc(date)
          .set(progressData, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('Günlük progress kaydedilemedi: $e');
      return false;
    }
  }

  // ✅ Günlük takip verilerini al
  Future<Map<String, dynamic>?> getDailyProgress(
    String userId,
    String date,
  ) async {
    try {
      final doc =
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('daily_progress')
              .doc(date)
              .get();

      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('Günlük progress alınamadı: $e');
      return null;
    }
  }
}
