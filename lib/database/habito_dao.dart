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
    
  Future<void> salvarHabito(Map<String, dynamic> habito) async {
    Database db = await DatabaseHelper().initDB();
    await db.insert('habitos', habito);
  }

  Future<List<Map<String, dynamic>>> listarHabitos() async {
    List<Map<String, dynamic>> listaHabitos = [];
    Database db = await DatabaseHelper().initDB();

    String sql = 'SELECT * FROM habitos ORDER BY data DESC;';
    var listResult = await db.rawQuery(sql);

    for (var item in listResult) {
      listaHabitos.add(item);
    }

    return listaHabitos;
  }
}
