import 'package:dio/dio.dart';
import '../model/diario_model.dart';

class DiarioApi {
  final dio = Dio();
  final String baseUrl =
      'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Diario>> findAll() async {
    List<Diario> listaDiario = [];

    try {
      final response = await dio.get('$baseUrl/diario');
      print('Status code da API: ${response.statusCode}');
      print('Dados brutos da API: ${response.data}');

      if (response.statusCode == 200) {
        var listResult = response.data;

        // Se a resposta for uma lista (como o esperado)
        if (listResult is List) {
          for (var json in listResult) {
            Diario diario = Diario.fromJson(json);
            listaDiario.add(diario);
          }
        }
        // Caso venha um objeto com chave "diario"
        else if (listResult is Map && listResult['diario'] is List) {
          for (var json in listResult['diario']) {
            Diario diario = Diario.fromJson(json);
            listaDiario.add(diario);
          }
        } else {
          print('⚠️ Formato inesperado de resposta da API: ${listResult.runtimeType}');
        }
      } else {
        print('❌ Erro ao buscar diário: código ${response.statusCode}');
      }
    } catch (e) {
      print('🚨 Erro ao acessar a API de diário: $e');
    }

    return listaDiario;
  }
}
