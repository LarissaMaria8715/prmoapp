import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/calm/imagem_model.dart';

class calmApi {
  static const String baseUrl = 'https://picsum.photos/v2/list';

  static Future<List<ImagemModel>> fetchImagens() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ImagemModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar imagens');
    }
  }

}