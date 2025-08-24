import 'package:sqflite/sqflite.dart';
import '../model/diario_model.dart';
import 'database_helper.dart';

class DiarioDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<Database> _getDatabase() async {
    return await _dbHelper.initDB();
  }

  // Inserir uma nova entrada no diário
  Future<int> salvar(Diario diario) async {
    final db = await _getDatabase();
    return await db.insert('diario', diario.toJson());
  }

  // Listar todas as entradas de um usuário
  Future<List<Diario>> listarPorUsuario(int usuarioId) async {
    final db = await _getDatabase();
    final result = await db.query(
      'diario',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
    return result.map((json) => Diario.fromJson(json)).toList();
  }

  // Deletar uma entrada pelo id
  Future<int> deletar(int id) async {
    final db = await _getDatabase();
    return await db.delete('diario', where: 'id = ?', whereArgs: [id]);
  }
}
