import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class GeminiService {
  static Future<String> fetchResponse(String prompt) async {
    final uri = Uri.parse('${AppConstants.geminiUrl}?key=${AppConstants.geminiApiKey}');

    final response = await http.post(uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {"parts": [{"text": prompt}]}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"].trim();
    } else {
      return "Oops, something went wrong.";
    }
  }
}
