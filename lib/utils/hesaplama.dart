String gunlukSuIhtiyaci(double kilo) {
  final litre = (kilo * 35) / 1000; // 35 ml / kg
  return '${litre.toStringAsFixed(1)} L';
}

String gunlukKaloriIhtiyaci(double kilo) {
  final kalori = kilo * 30; // Basit BMR formülü
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
