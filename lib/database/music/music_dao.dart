import '../../api/music/music_api.dart';
import '../../model/music/music_model.dart';

class MusicDao {
  final MusicApi api = MusicApi();

  Future<List<Music>> findAll() async {
    return await api.getTopTracks();
  }
}
