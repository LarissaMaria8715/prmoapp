import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import '../../../model/places/parks/park.dart';

class ParksApi {
  final dio = Dio();
  final String baseUrl =
      'https://my-json-server.typicode.com/LarissaMaria8715/Lugares-API';

  Future<List<Park>> findAll() async {
    print('[PARKS_API] Iniciando request...');
    final response = await dio.get('$baseUrl/parques');
    print('[PARKS_API] Status code: ${response.statusCode}');
    print('[PARKS_API] Dados recebidos: ${response.data}');

    List<Park> parques = [];

    if (response.statusCode == 200) {
      for (var json in response.data) {
        print('[PARKS_API] Processando parque: ${json['nome']}');

        try {
          final endereco = json['endereco'];
          print('[PARKS_API] Fazendo geocoding -> $endereco');

          final locations = await locationFromAddress(endereco);
          final loc = locations.first;
          print('[PARKS_API] Geocoding OK → lat: ${loc.latitude}, lng: ${loc.longitude}');

          Park finalPark = Park(
            nome: json['nome'],
            endereco: endereco,
            latitude: loc.latitude,
            longitude: loc.longitude,
            imagem: json['imagem'] ?? 'assets/images/equilibre.jpg',
          );

          parques.add(finalPark);
        } catch (e) {
          print('[PARKS_API] ERRO NO GEOCODING: $e');
        }
      }
    }

    print('[PARKS_API] Resultado final: ${parques.length} parques');
    return parques;
  }
}
