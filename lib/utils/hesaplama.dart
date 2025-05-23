// utils/hesaplama.dart

/// Günlük su ihtiyacını hesaplar (L cinsinden)
String gunlukSuIhtiyaci(double kilo) {
  // Genel formül: Kilo x 35ml
  double suMiktari = (kilo * 35) / 1000; // Litre cinsinden
  return '${suMiktari.toStringAsFixed(1)}L';
}

/// BMR (Bazal Metabolizma Hızı) ve günlük kalori ihtiyacını hesaplar
String gunlukKaloriIhtiyaci(
  double kilo, {
  required double boy,
  required int yas,
  required String cinsiyet,
}) {
  double bmr;

  // Harris-Benedict formülü
  if (cinsiyet.toLowerCase() == 'erkek') {
    bmr = 88.362 + (13.397 * kilo) + (4.799 * boy) - (5.677 * yas);
  } else {
    bmr = 447.593 + (9.247 * kilo) + (3.098 * boy) - (4.330 * yas);
  }

  // Hafif aktif yaşam tarzı için BMR x 1.375
  // (Haftada 1-3 gün hafif egzersiz)
  double gunlukKalori = bmr * 1.375;

  return '${gunlukKalori.round()}';
}

/// Yaşa göre günlük adım hedefini hesaplar
String gunlukAdimHedefi(int yas) {
  if (yas < 18) {
    return '12K'; // Gençler için daha yüksek
  } else if (yas <= 30) {
    return '10K'; // Genç yetişkinler
  } else if (yas <= 50) {
    return '8K'; // Orta yaş
  } else if (yas <= 65) {
    return '6K'; // Yaşlı yetişkinler
  } else {
    return '4K'; // 65+ yaş
  }
}

/// Kiloya göre daha detaylı su hesaplama (aktivite seviyesi dahil)
String detayliSuIhtiyaci(double kilo, {String aktiviteSeviyesi = 'orta'}) {
  double baseAmount = kilo * 35; // ml cinsinden

  switch (aktiviteSeviyesi.toLowerCase()) {
    case 'düşük':
      baseAmount *= 1.0;
      break;
    case 'orta':
      baseAmount *= 1.2;
      break;
    case 'yüksek':
      baseAmount *= 1.5;
      break;
  }

  return '${(baseAmount / 1000).toStringAsFixed(1)}L';
}

/// Kilo hedefine göre kalori hesaplama (kilo verme/alma/koruma)
String kaloriHedefiHesapla(
  double kilo, {
  required double boy,
  required int yas,
  required String cinsiyet,
  required String hedef, // 'koruma', 'verme', 'alma'
}) {
  double bmr;

  if (cinsiyet.toLowerCase() == 'erkek') {
    bmr = 88.362 + (13.397 * kilo) + (4.799 * boy) - (5.677 * yas);
  } else {
    bmr = 447.593 + (9.247 * kilo) + (3.098 * boy) - (4.330 * yas);
  }

  double gunlukKalori = bmr * 1.375; // Hafif aktif

  switch (hedef.toLowerCase()) {
    case 'verme':
      gunlukKalori -= 500; // Günde 500 kalori eksik = haftada 0.5kg
      break;
    case 'alma':
      gunlukKalori += 500; // Günde 500 kalori fazla = haftada 0.5kg
      break;
    case 'koruma':
    default:
      // Mevcut kalori miktarı korunur
      break;
  }

  return '${gunlukKalori.round()}';
}
