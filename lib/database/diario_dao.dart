import 'database_helper.dart';

class DiarioDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertDiario(Map<String, dynamic> entrada) async {
    final db = await _dbHelper.initDB();
    return await db.insert('diario', entrada);
  }

  Future<List<Map<String, dynamic>>> getEntradasDiario(int usuarioId) async {
    final db = await _dbHelper.initDB();
    return await db.query(
      'diario',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
  }
}
