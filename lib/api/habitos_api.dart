import 'package:dio/dio.dart';
import '../model/habito_model.dart';

class HabitosApi {
  final dio = Dio();
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Habito>> findAll() async {
    try {
      final response = await dio.get('$baseUrl/habitos');

      if (response.statusCode == 200) {
        final list = response.data as List;
        return list.map((json) => Habito.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('❌ Erro ao buscar hábitos da API: $e');
      return [];
    }
  }
}
