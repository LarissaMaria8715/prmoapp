
import 'dart:convert';
import 'package:http/http.dart' as http;

class LivrosApi {
  static const String baseUrl = 'https://openlibrary.org/search.json?q=*&language=por&fields=title,author_name,cover_i';

  static Future<Map<String, dynamic>> fetchLivrosRaw() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar livros: ${response.statusCode}');
    }
    return json.decode(response.body);
  }
}

