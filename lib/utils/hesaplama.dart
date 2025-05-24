/// Günlük su ihtiyacını hesaplar (L cinsinden)
String gunlukSuIhtiyaci(double kilo) {
  double suMiktari = (kilo * 35) / 1000;
  return '${suMiktari.toStringAsFixed(1)}L';
}

/// BMR (Bazal Metabolizma Hızı) ve günlük kalori ihtiyacını hesaplar
String gunlukKaloriIhtiyaci(
  double kilo, {
  required double boy,
  required int yas,
  required String cinsiyet,
  required String aktiviteSeviyesi,
}) {
  double bmr;

  if (cinsiyet.toLowerCase() == 'erkek') {
    bmr = 88.362 + (13.397 * kilo) + (4.799 * boy) - (5.677 * yas);
  } else {
    bmr = 447.593 + (9.247 * kilo) + (3.098 * boy) - (4.330 * yas);
  }

  double katsayi;
  switch (aktiviteSeviyesi.toLowerCase()) {
    case 'yüksek':
      katsayi = 1.725;
      break;
    case 'düşük':
      katsayi = 1.2;
      break;
    default:
      katsayi = 1.375; // orta
  }

  double gunlukKalori = bmr * katsayi;
  return '${gunlukKalori.round()}';
}

/// Yaşa göre günlük adım hedefini hesaplar
String gunlukAdimHedefi(int yas) {
  if (yas < 18) {
    return '12K';
  } else if (yas <= 30) {
    return '10K';
  } else if (yas <= 50) {
    return '8K';
  } else if (yas <= 65) {
    return '6K';
  } else {
    return '4K';
  }
}

/// Kiloya göre detaylı su hesaplama (aktivite seviyesi dahil)
String detayliSuIhtiyaci(double kilo, {String aktiviteSeviyesi = 'orta'}) {
  double baseAmount = kilo * 35;

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

/// Kilo hedefine göre kalori hesaplama
String kaloriHedefiHesapla(
  double kilo, {
  required double boy,
  required int yas,
  required String cinsiyet,
  required String hedef,
}) {
  double bmr;

  if (cinsiyet.toLowerCase() == 'erkek') {
    bmr = 88.362 + (13.397 * kilo) + (4.799 * boy) - (5.677 * yas);
  } else {
    bmr = 447.593 + (9.247 * kilo) + (3.098 * boy) - (4.330 * yas);
  }

  double gunlukKalori = bmr * 1.375;

  switch (hedef.toLowerCase()) {
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

  return '${gunlukKalori.round()}';
}