import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class HabitoDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> salvarHabito(Map<String, dynamic> habito) async {
    final db = await _dbHelper.initDB();
    return await db.insert('habitos', habito);
  }

  Future<List<Map<String, dynamic>>> listarHabitos() async {
    final db = await _dbHelper.initDB();
    return await db.query(
      'habitos',
      orderBy: 'data DESC',
    );
  }
}