import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HumorDAO {
  Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'equilibre.db');

    return openDatabase(path, version: 1);
  }

  Future<int> insertHumor(int usuarioId, String humorLabel, String humorEmoji, String data) async {
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

  Future<List<Map<String, dynamic>>> getHumoresByUser(int usuarioId) async {
    final db = await _getDatabase();
    return await db.query(
      'humor',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
  }

  Future<int> deleteHumor(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      'humor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
