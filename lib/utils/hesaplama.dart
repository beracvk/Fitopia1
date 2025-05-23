String gunlukSuIhtiyaci(double kilo) {
  final litre = (kilo * 35) / 1000; // 35 ml / kg
  return '${litre.toStringAsFixed(1)} L';
}

String gunlukKaloriIhtiyaci(
  double kiloParam, {
  required double boy,
  required int yas,
  required String cinsiyet,
}) {
  double bmr;

  if (cinsiyet.toLowerCase() == 'erkek') {
    bmr = 10 * kiloParam + 6.25 * boy - 5 * yas + 5;
  } else {
    bmr = 10 * kiloParam + 6.25 * boy - 5 * yas - 161;
  }

  final kalori = bmr * 1.3; // Hafif aktif
  return '${kalori.toStringAsFixed(0)} kcal';
}

String gunlukAdimHedefi(int yas) {
  int adim = 8000;
  if (yas < 18) {
    adim = 10000;
  } else if (yas > 60) {
    adim = 6000;
  }
  return '$adim adım';
}
