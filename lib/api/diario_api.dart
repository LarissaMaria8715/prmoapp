import 'package:dio/dio.dart';
import '../model/diario_model.dart';

class DiarioApi {
  final dio = Dio();
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Diario>> findAll() async {
    List<Diario> listaDiario = [];

    final response = await dio.get('$baseUrl/diario');

    if (response.statusCode == 200) {
      var listResult = response.data;
      for (var json in listResult) {
        Diario diario = Diario.fromJson(json);
        listaDiario.add(diario);
      }
    }

    return listaDiario;
  }
}
