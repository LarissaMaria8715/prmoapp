import '../api/livro_api.dart';
import '../model/livro_model.dart';

class LivroDao {
  static Future<List<Livro>> getLivros() async {
    final data = await LivrosApi.fetchLivrosRaw();
    final List docs = data['docs'] ?? [];
    return docs.map<Livro>((json) => Livro.fromJson(json)).toList();
  }
}
