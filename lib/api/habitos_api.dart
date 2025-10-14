import 'package:dio/dio.dart';
import '../model/habito_model.dart';

class HabitosApi {
  final dio = Dio();
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Habito>> findAll() async {
    List<Habito> listaHabitos = [];

    final response = await dio.get('$baseUrl/habitos');

    if (response.statusCode == 200) {
      var listResult = response.data;
      for (var json in listResult) {
        Habito habito = Habito.fromJson(json);
        listaHabitos.add(habito);
      }
    }
    return listaHabitos;
  }
}