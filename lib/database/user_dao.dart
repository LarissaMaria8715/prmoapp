import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';
import 'database_helper.dart';

class UsuarioDAO {
  Future<Database> _pegarBanco() async {
    return await DatabaseHelper().initDB();
  }

  Future<int> salvar(Usuario usuario) async {
    final db = await _pegarBanco();
    return await db.insert('usuarios', usuario.toJson());
  }

  Future<int> atualizar(Usuario usuario) async {
    final db = await _pegarBanco();
    return await db.update(
      'usuarios',
      usuario.toJson(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<List<Map<String, dynamic>>> listarTodos() async {
    final db = await _pegarBanco();
    return await db.query('usuarios');
  }

  Future<Map<String, dynamic>?> buscarPorId(int id) async {
    final db = await _pegarBanco();
    final result = await db.query('usuarios', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> buscarPorEmail(String email) async {
    final db = await _pegarBanco();
    final result = await db.query('usuarios', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> validar(String email, String senha) async {
    final db = await _pegarBanco();
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }

  Future<int> deletar(int id) async {
    final db = await _pegarBanco();
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}
