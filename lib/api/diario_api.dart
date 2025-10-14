import 'package:dio/dio.dart';
import '../model/diario_model.dart';

class DiarioApi {
  final Dio dio = Dio();
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Diario>> findAll() async {
    List<Diario> listaDiario = [];

    try {
      final response = await dio.get('$baseUrl/diario');
      print('Status code da API: ${response.statusCode}');
      print('Dados brutos da API: ${response.data}');  // DEBUG

      if (response.statusCode == 200) {
        var body = response.data;

        // Se vier um mapa com chave "diario"
        if (body is Map && body['diario'] is List) {
          for (var json in body['diario']) {
            listaDiario.add(Diario.fromJson(json));
          }
        }
        // Se já for lista diretamente.
        else if (body is List) {
          for (var json in body) {
            listaDiario.add(Diario.fromJson(json));
          }
        } else {
          print('Formato inesperado de dados da API: ${body.runtimeType}');
        }
      } else {
        print('Erro: status code diferente de 200');
      }
    } catch (e, stack) {
      print('Erro ao buscar dados da API: $e');
      print(stack);
    }
    return listaDiario;
  }
}
