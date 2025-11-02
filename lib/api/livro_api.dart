import 'dart:convert';
import 'package:http/http.dart' as http;

class LivrosApi {
  static const String baseUrl = 'https://openlibrary.org/search.json?q=*&language=por&fields=title,author_name,cover_i,subtitle&limit=30';

  static Future<Map<String, dynamic>> fetchLivrosRaw() async {
    final uri = Uri.parse(baseUrl);

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar livros: ${response.statusCode}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
