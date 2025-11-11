import 'package:dio/dio.dart';
import '../../model/quote/quote_model.dart';
import '../translation/translation_api.dart';

class MotivacaoApi {
  final dio = Dio();
  final String apiUrl = 'https://zenquotes.io/api/quotes';
  final TranslationApi _translationApi = TranslationApi();

  Future<List<Quote>> findQuotes() async {
    List<Quote> listaQuotes = [];
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        var listResult = response.data;
        for (var json in listResult) {
          Quote quote = Quote.fromJson(json);
          listaQuotes.add(quote);
        }
        await Future.wait(listaQuotes.map((quote) async {
          quote.translatedQuote = await _translationApi.translateText(
            text: quote.quote,
          );
        }));
      } else {
        throw Exception('Failed to load quotes. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network Error: ${e.message}');
    }
    return listaQuotes;
  }
}