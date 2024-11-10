import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslatorApi {
  static const String apiUrl =
      'https://free-google-translator.p.rapidapi.com/external-api/free-google-translator';
  static const String apiKey =
      '17a1a2336fmshf64e8a0181f053dp1ca554jsne3041c67cc23';

  Future<String?> translateText(
      String text, String fromLang, String toLang) async {
    final url = Uri.parse(
        '$apiUrl?from=$fromLang&to=$toLang&query=${Uri.encodeComponent(text)}');
    final headers = {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': 'free-google-translator.p.rapidapi.com',
      'Content-Type': 'application/json',
    };
    final payload = json.encode({'translate': text});

    try {
      final response = await http.post(url, headers: headers, body: payload);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // Assuming response format has "translationText" or similar as the translated text key
        return jsonData['translation'] ?? "No translation available";
      } else {
        print('API response error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('API call error: $e');
      return null;
    }
  }
}
