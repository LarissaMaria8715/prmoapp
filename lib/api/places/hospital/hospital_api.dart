import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';

import '../../../model/places/hospital/hospital.dart';

class HospitalsApi {
  final dio = Dio();
  final String baseUrl =
      'https://my-json-server.typicode.com/LarissaMaria8715/Lugares-API';

  Future<List<Hospital>> findAll() async {
    print('[HOSPITALS_API] Iniciando request...');
    final response = await dio.get('$baseUrl/hospitais');
    print('[HOSPITALS_API] Status: ${response.statusCode}');
    print('[HOSPITALS_API] Dados recebidos: ${response.data}');

    List<Hospital> hospitais = [];

    if (response.statusCode == 200) {
      for (var json in response.data) {
        print('[HOSPITALS_API] Processando: ${json['nome']}');

        try {
          final locations = await locationFromAddress(json['endereco']);
          final loc = locations.first;

          Hospital finalHosp = Hospital(
            id: json['id'] ?? 0,
            nome: json['nome'],
            endereco: json['endereco'],
            telefone: json['telefone'],
            imagem: json['imagem'] ?? 'assets/images/equilibre.jpg',
          );


          hospitais.add(finalHosp);
        } catch (e) {
          print('[HOSPITALS_API] ERRO NO GEOCODING: $e');
        }
      }
    }

    print('[HOSPITALS_API] Total carregado: ${hospitais.length}');
    return hospitais;
  }
}
