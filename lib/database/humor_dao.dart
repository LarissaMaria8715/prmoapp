import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class HumorDAO {

  Future<Database> _getDatabase() async {
    return await DatabaseHelper().initDB();
  }

  Future<int> salvar(int usuarioId, String humorLabel, String humorEmoji, String data) async {
    final db = await _getDatabase();
    return await db.insert(
      'humor',
      {
        'usuario_id': usuarioId,
        'humorLabel': humorLabel,
        'humorEmoji': humorEmoji,
        'data': data,
      },
    );
  }

  Future<List<Map<String, dynamic>>> listarPorUsuario(int usuarioId) async {
    final db = await _getDatabase();
    return await db.query(
      'humor',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
  }

  Future<int> deletar(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      'humor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
