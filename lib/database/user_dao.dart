import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class UserDAO {
  Future<Database> _getDatabase() async {
    return await DatabaseHelper().initDB();
  }

  Future<int> insert(Map<String, dynamic> user) async {
    final db = await _getDatabase();
    return await db.insert('usuarios', user);
  }

  Future<int> update(Map<String, dynamic> user) async {
    final db = await _getDatabase();
    return await db.update(
      'usuarios',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _getDatabase();
    return await db.query('usuarios');
  }

  Future<Map<String, dynamic>?> getById(int id) async {
    final db = await _getDatabase();
    final result = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getByEmail(String email) async {
    final db = await _getDatabase();
    final result = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> validate(String email, String senha) async {
    final db = await _getDatabase();
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }
}
