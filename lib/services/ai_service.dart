import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const _apiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
  ); // dotenv ile güvenli saklayacağız

  static Future<Map<String, dynamic>> generateNutrition(String meal) async {
    final prompt =
        "Provide an estimated nutritional breakdown for a healthy $meal. Include calories, carbs, protein, fat.";

    final response = await http.post(
      Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey',
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['candidates'][0]['content']['parts'][0]['text'];

      return _parseNutrition(content);
    } else {
      throw Exception('API Error: ${response.body}');
    }
  }

  static Map<String, dynamic> _parseNutrition(String content) {
    final Map<String, dynamic> result = {};
    final regexMap = {
      'calories': RegExp(r'(\d+)\s*kcal'),
      'carbs': RegExp(r'(\d+)\s*g\s*carbs?'),
      'protein': RegExp(r'(\d+)\s*g\s*protein'),
      'fat': RegExp(r'(\d+)\s*g\s*fat'),
    };

    regexMap.forEach((key, regex) {
      final match = regex.firstMatch(content.toLowerCase());
      if (match != null) {
        result[key] = int.tryParse(match.group(1) ?? '0') ?? 0;
      }
    });

    return result;
  }
}
