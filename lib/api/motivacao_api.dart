// lib/api/motivacao_api.dart
import 'package:dio/dio.dart';
import '../model/quote_model.dart';
import 'translation_api.dart'; // Importa a nova classe de tradução

class MotivacaoApi {
  final dio = Dio();
  final String apiUrl = 'https://zenquotes.io/api/quotes';

  // Instancia a API de Tradução
  final TranslationApi _translationApi = TranslationApi();

  Future<List<Quote>> findQuotes() async {
    List<Quote> listaQuotes = [];

    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        var listResult = response.data;

        // 1. Converte todos os JSONs em objetos Quote
        for (var json in listResult) {
          Quote quote = Quote.fromJson(json);
          listaQuotes.add(quote);
        }

        // 2. Itera sobre a lista e traduz cada citação
        // Usamos Future.wait para traduzir todas as frases em paralelo, sendo mais rápido
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