import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/humor_model.dart';

class HumorApi {
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api/db';

  Future<List<Humor>> findAll() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final humoresJson = data['humor'] as List;
      return humoresJson.map((h) => Humor.fromJson(h)).toList();
    } else {
      throw Exception('Falha ao carregar humores da API');
    }
  }
}



