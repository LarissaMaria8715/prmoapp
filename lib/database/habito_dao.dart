import 'package:sqflite/sqflite.dart';
import '../model/habito_model.dart';
import 'database_helper.dart';

class HabitoDAO {
  Future<Database> _getDatabase() async {
    return await DatabaseHelper().initDB();
  }

  Future<int> inserirHabito(Habito habito) async {
    final db = await _getDatabase();
    return await db.insert('habitos', habito.toJson());
  }

  Future<List<Habito>> listarHabitos(int usuarioId) async {
    final db = await _getDatabase();
    final resultado = await db.query(
      'habitos',
      where: 'usuarioId = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
    return resultado.map((json) => Habito.fromJson(json)).toList();
  }

  Future<Habito?> buscarPorId(int id) async {
    final db = await _getDatabase();
    final resultado = await db.query(
      'habitos',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (resultado.isNotEmpty) {
      return Habito.fromJson(resultado.first);
    }
    return null;
  }

  Future<int> atualizarHabito(Habito habito) async {
    final db = await _getDatabase();
    return await db.update(
      'habitos',
      habito.toJson(),
      where: 'id = ?',
      whereArgs: [habito.id],
    );
  }

  Future<int> excluirHabito(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      'habitos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> excluirTodosDoUsuario(int usuarioId) async {
    final db = await _getDatabase();
    return await db.delete(
      'habitos',
      where: 'usuarioId = ?',
      whereArgs: [usuarioId],
    );
  }
}
