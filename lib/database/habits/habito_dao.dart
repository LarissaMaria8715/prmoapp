import 'package:sqflite/sqflite.dart';
import '../../model/habits/habito_model.dart';
import '../helper/database_helper.dart';

class HabitoDAO {
  Future<Database> _getDatabase() async {
    return await DatabaseHelper().initDB();
  }

  Future<int> inserirHabito(Habito habito) async {
    final db = await _getDatabase();
    return await db.insert(
      'habitos',
      habito.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Habito>> listarHabitos(int usuarioId) async {
    final db = await _getDatabase();
    final maps = await db.query(
      'habitos',
      where: 'usuarioId = ?',
      whereArgs: [usuarioId],
      orderBy: 'data DESC',
    );

    return maps.map((m) => Habito.fromJson(m)).toList();
  }

  Future<bool> existeHabitoComId(int id) async {
    final db = await _getDatabase();
    final result = await db.query('habitos', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
