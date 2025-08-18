import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class HabitoDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Salva um hábito no banco de dados.
  /// Retorna o ID da linha inserida.
  Future<int> salvarHabito(Map<String, dynamic> habito) async {
    final db = await _dbHelper.initDB();
    return await db.insert('habitos', habito);
  }

  /// Lista todos os hábitos salvos, ordenados por data decrescente.
  Future<List<Map<String, dynamic>>> listarHabitos() async {
    final db = await _dbHelper.initDB();
    return await db.query(
      'habitos',
      orderBy: 'data DESC',
    );
  }
}
