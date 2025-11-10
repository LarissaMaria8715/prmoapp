import 'package:dio/dio.dart';
import '../model/humor_model.dart';

class HumorApi {
  final dio = Dio();
  final String baseUrl =
      'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Humor>> findAll() async {
    List<Humor> listaHumores = [];

    final response = await dio.get('$baseUrl/humor');

    if (response.statusCode == 200) {
      var listResult = response.data;
      for (var json in listResult) {
        Humor humor = Humor.fromJson(json);
        listaHumores.add(humor);
      }
    }

    await Future.delayed(const Duration(seconds: 3));

    return listaHumores;
  }
}