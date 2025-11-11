import 'package:dio/dio.dart';

class TranslationApi {
  final dio = Dio();
  final String baseUrl = 'https://translate.terraprint.co';

  Future<String> translateText({
    required String text,
    String sourceLang = 'en',
    String targetLang = 'pt',
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/translate',
        data: {
          'q': text,
          'source': sourceLang,
          'target': targetLang,
          'format': 'text',
          'api_key': '',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['translatedText'] ?? text;
      }
      return text;

    } on DioException {
      return text;
    } catch (e) {
      return text;
    }
  }
}