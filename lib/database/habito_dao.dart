import 'package:sqflite/sqflite.dart';
import '../model/habito_model.dart';
import 'database_helper.dart';

class HabitoDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<Database> _getDatabase() async {
    return await _dbHelper.initDB();
  }

  // Salvar um novo hábito
  Future<int> salvarHabito(Habito habito) async {
    final db = await _getDatabase();
    return await db.insert('habitos', habito.toJson());
  }

  // Listar todos os hábitos
  Future<List<Habito>> listarHabitos() async {
    final db = await _getDatabase();
    final result = await db.query(
      'habitos',
      orderBy: 'data DESC',
    );
    return result.map((json) => Habito.fromJson(json)).toList();
  }

  // Deletar hábito pelo id
  Future<int> deletar(int id) async {
    final db = await _getDatabase();
    return await db.delete('habitos', where: 'id = ?', whereArgs: [id]);
  }
}
