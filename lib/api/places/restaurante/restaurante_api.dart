import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';

import '../../../model/places/restaurante.dart';

class RestaurantsApi {
  final dio = Dio();
  final String baseUrl =
      'https://my-json-server.typicode.com/LarissaMaria8715/Lugares-API';

  Future<List<Restaurant>> findAll() async {
    print('[RESTAURANTS_API] Iniciando request...');
    final response = await dio.get('$baseUrl/restaurantes');
    print('[RESTAURANTS_API] Status code: ${response.statusCode}');
    print('[RESTAURANTS_API] Dados recebidos: ${response.data}');

    List<Restaurant> restaurantes = [];

    if (response.statusCode == 200) {
      for (var json in response.data) {
        print('[RESTAURANTS_API] Processando restaurante: ${json['nome']}');

        Restaurant tmp = Restaurant(
          nome: json['nome'],
          endereco: json['endereco'],
          latitude: 0,
          longitude: 0,
          tipo: json['tipo'] ?? 'Indefinido',
          telefone: json['telefone'] ?? '',
        );

        try {
          print('[RESTAURANTS_API] Fazendo geocoding -> ${tmp.endereco}');
          final locations = await locationFromAddress(tmp.endereco);
          final loc = locations.first;
          print(
              '[RESTAURANTS_API] Geocoding OK → lat: ${loc.latitude}, lng: ${loc.longitude}'
          );

          Restaurant finalRest = Restaurant(
            nome: tmp.nome,
            endereco: tmp.endereco,
            latitude: loc.latitude,
            longitude: loc.longitude,
            tipo: tmp.tipo,
            telefone: tmp.telefone,
          );

          restaurantes.add(finalRest);
        } catch (e) {
          print('[RESTAURANTS_API] ERRO NO GEOCODING: $e');
        }
      }
    }

    print('[RESTAURANTS_API] Resultado final: ${restaurantes.length} restaurantes');
    return restaurantes;
  }
}
