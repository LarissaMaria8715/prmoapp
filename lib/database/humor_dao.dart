import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HumorDAO {
  static const _databaseName = "equilibre.db"; // mesmo banco principal
  static const _databaseVersion = 1;
  static const table = 'humor'; // nome da tabela no DatabaseHelper

  Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
    );
  }

  /// Inserir humor
  Future<int> insertHumor({
    required int usuarioId,
    required String humorLabel,
    required String humorEmoji,
    required String data,
  }) async {
    final db = await _getDatabase();
    return await db.insert(table, {
      'usuario_id': usuarioId,
      'humorLabel': humorLabel,
      'humorEmoji': humorEmoji,
      'data': data,
    });
  }

  /// Buscar todos os humores de um usuário
  Future<List<Map<String, dynamic>>> getHumoresByUser(int usuarioId) async {
    final db = await _getDatabase();
    return await db.query(
      table,
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'id DESC',
    );
  }

  /// Excluir um humor
  Future<int> deleteHumor(int id) async {
    final db = await _getDatabase();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  /// Atualizar um humor
  Future<int> updateHumor({
    required int id,
    required String humorLabel,
    required String humorEmoji,
    required String data,
  }) async {
    final db = await _getDatabase();
    return await db.update(
      table,
      {
        'humorLabel': humorLabel,
        'humorEmoji': humorEmoji,
        'data': data,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
