import 'package:sqflite/sqflite.dart';
import '../model/humor_model.dart';
import 'database_helper.dart';

class HumorDAO {
  Future<Database> _getDatabase() async {
    return await DatabaseHelper().initDB();
  }
  Future<int> salvar(Humor humor) async {
    final db = await _getDatabase();
    return await db.insert('humor', humor.toJson());
  }
  Future<List<Humor>> listarPorUsuario(int usuarioId) async {
    final db = await _getDatabase();
    final result = await db.query(
      'humor',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
    return result.map((json) => Humor.fromJson(json)).toList();
  }
  Future<int> deletar(int id) async {
    final db = await _getDatabase();
    return await db.delete(
        'humor',
        where: 'id = ?',
        whereArgs: [id]
    );
  }
}