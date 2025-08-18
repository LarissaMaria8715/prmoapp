import 'package:sqflite/sqflite.dart';
import 'package:equilibreapp/database/database_helper.dart';

class MetaDAO {
  static Future<void> inserirMeta(Map<String, dynamic> meta) async {
    final db = await DatabaseHelper().initDB();
    await db.insert('metas', meta);
  }

  static Future<List<Map<String, dynamic>>> listarMetas() async {
    final db = await DatabaseHelper().initDB();
    final List<Map<String, dynamic>> maps = await db.query('metas');
    return maps;
  }

  static Future<void> atualizarMeta(Map<String, dynamic> meta) async {
    final db = await DatabaseHelper().initDB();
    await db.update(
      'metas',
      meta,
      where: 'id = ?',
      whereArgs: [meta['id']],
    );
  }

  static Future<void> deletarMeta(int id) async {
    final db = await DatabaseHelper().initDB();
    await db.delete(
      'metas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
