import 'package:dio/dio.dart';
import '../../model/book/livro_model.dart';

class LivrosApi {
  final dio = Dio();
  final String baseUrl =
      'https://openlibrary.org/search.json?q=*&language=por&fields=title,author_name,cover_i,subtitle&limit=30';

  Future<List<Livro>> listarLivros() async {
    final response = await dio.get(baseUrl);

    final data = response.data;
    final livrosJson = data['docs'] as List;

    return livrosJson.map((json) => Livro.fromJson(json)).toList();
  }
}