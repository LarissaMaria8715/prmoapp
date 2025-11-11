import '../../api/calm/calm_api.dart';
import '../../model/calm/imagem_model.dart';


class ImagemDao {
  Future<List<ImagemModel>> obterImagens() async {
    try {
      return await calmApi.fetchImagens();
    } catch (e) {
      rethrow;
    }
  }
}
