import 'package:dio/dio.dart';
import '../../model/music/music_model.dart';

class MusicApi {
  final Dio dio = Dio();

  Future<List<Music>> getTopTracks() async {
    try {
      final response = await dio.get('https://api.deezer.com/chart/0/tracks');
      final data = response.data['data'];

      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => Music.fromJsonDeezer(json))
            .toList();
      }
      return [];
    } catch (e) {
      print('Erro na API Deezer: $e');
      return [];
    }
  }
}
