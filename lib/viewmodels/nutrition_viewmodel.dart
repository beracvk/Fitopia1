import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class NutritionViewModel extends ChangeNotifier {
  Map<String, dynamic>? nutrition;
  bool isLoading = false;

  Future<void> fetchNutrition(String meal) async {
    isLoading = true;
    notifyListeners();

    try {
      nutrition = await AIService.generateNutrition(meal);
    } catch (e) {
      nutrition = null;
    }

    isLoading = false;
    notifyListeners();
  }
}
