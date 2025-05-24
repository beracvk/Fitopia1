/// Günlük su ihtiyacını hesaplar (L cinsinden)
double gunlukSuIhtiyaci(double kilo) {
  return (kilo * 35) / 1000; // Örn: 2.5 litre
}

/// Günlük kalori ihtiyacını hesaplar (BMR + aktivite katsayısı)
int gunlukKaloriIhtiyaci(
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

  return (bmr * katsayi).round();
}

/// Yaşa göre günlük adım hedefi (sayı cinsinden)
int gunlukAdimHedefi(int yas) {
  if (yas < 18) return 12000;
  if (yas <= 30) return 10000;
  if (yas <= 50) return 8000;
  if (yas <= 65) return 6000;
  return 4000;
}

/// Aktiviteye göre detaylı su ihtiyacı (L)
double detayliSuIhtiyaci(double kilo, {String aktiviteSeviyesi = 'orta'}) {
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

  return (baseAmount / 1000); // litre
}

/// Kalori hedefi hesaplama (kilo verme/alma/koruma)
int kaloriHedefiHesapla(
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

  double kalori = bmr * 1.375;

  switch (hedef.toLowerCase()) {
    case 'verme':
      kalori -= 500;
      break;
    case 'alma':
      kalori += 500;
      break;
    default:
      break;
  }

  return kalori.round();
}
