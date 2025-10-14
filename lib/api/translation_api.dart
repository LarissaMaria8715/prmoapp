// lib/api/translation_api.dart
import 'package:dio/dio.dart';

class TranslationApi {
  final dio = Dio();
  // Instância pública do LibreTranslate. ATENÇÃO: pode ter limites de uso.
  final String baseUrl = 'https://translate.terraprint.co';

  Future<String> translateText({
    required String text,
    String sourceLang = 'en', // Inglês (API ZenQuotes)
    String targetLang = 'pt', // Português
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/translate',
        data: {
          'q': text,
          'source': sourceLang,
          'target': targetLang,
          'format': 'text',
          // A chave é opcional para esta instância pública
          'api_key': '',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        // A resposta do LibreTranslate tem a tradução em 'translatedText'
        return response.data['translatedText'] ?? text;
      }

      // Retorna o texto original em caso de erro na tradução
      return text;

    } on DioException {
      // Em caso de erro de rede ou API, retorna o texto original (em inglês)
      return text;
    } catch (e) {
      // Outros erros
      return text;
    }
  }
}