import 'package:sqflite/sqflite.dart';
import 'package:equilibreapp/database/database_helper.dart';
import 'package:equilibreapp/model/meta_model.dart';

class MetaDAO {
  static Future<void> inserirMeta(Meta meta) async {
    final db = await DatabaseHelper().initDB();
    await db.insert('metas', meta.toMap());
  }

  static Future<List<Meta>> listarMetas() async {
    final db = await DatabaseHelper().initDB();
    final List<Map<String, dynamic>> maps = await db.query('metas');
    return maps.map((map) => Meta.fromMap(map)).toList();
  }

  static Future<void> atualizarMeta(Meta meta) async {
    final db = await DatabaseHelper().initDB();
    await db.update(
      'metas',
      meta.toMap(),
      where: 'id = ?',
      whereArgs: [meta.id],
    );
  }

  static Future<void> deletarMeta(int id) async {
    final db = await DatabaseHelper().initDB();
    await db.delete('metas', where: 'id = ?', whereArgs: [id]);
  }
}
