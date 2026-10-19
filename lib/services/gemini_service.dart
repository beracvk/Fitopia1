import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<String> generateText(String prompt) async {
    if (apiKey.isEmpty) {
      return 'Hata: Gemini API anahtarı bulunamadı.';
    }

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'x-goog-api-key': apiKey},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final candidates = data['candidates'] as List?;
        if (candidates == null || candidates.isEmpty) {
          return 'Gemini yanıt oluşturamadı.';
        }

        final parts = candidates[0]['content']['parts'] as List?;

        if (parts == null || parts.isEmpty) {
          return 'Gemini yanıtı boş geldi.';
        }

        return parts
            .where((part) => part['text'] != null)
            .map((part) => part['text'].toString())
            .join('\n');
      } else {
        return 'Gemini API hatası: ${response.statusCode}';
      }
    } catch (e) {
      return 'Gemini bağlantısı sırasında bir hata oluştu.';
    }
  }
}
