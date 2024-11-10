import 'package:google_translate/data/api/translator_api.dart';

class TranlatorRepository {
  final TranslatorApi _translatorApi;

  TranlatorRepository(this._translatorApi);

  Future<String?> translateText(
      String text, String fromLang, String toLang) async {
    try {
      return await _translatorApi.translateText(text, fromLang, toLang);
    } catch (e) {
      print('Repository error: $e');
      return null;
    }
  }
}
