import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user_model.dart';

class UserDAO {
  Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'equilibre.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            senha TEXT NOT NULL,
            dataNascimento TEXT,
            genero TEXT,
            altura REAL,
            peso REAL,
            objetivo TEXT,
            praticaMeditacao INTEGER,
            recebeNotificacoes INTEGER,
            condicaoSaude TEXT,
            telefone TEXT,
            cidade TEXT,
            estado TEXT
          )
        ''');

        await db.insert('users', {
          'nome': 'Larissa',
          'email': 'larissa@email.com',
          'senha': '123456',
          'dataNascimento': '2000-01-01',
          'genero': 'Feminino',
          'altura': 1.65,
          'peso': 60.0,
          'objetivo': 'Reduzir estresse',
          'praticaMeditacao': 1,
          'recebeNotificacoes': 1,
          'condicaoSaude': null,
          'telefone': '82999990000',
          'cidade': 'Arapiraca',
          'estado': 'AL',
        });

        await db.insert('users', {
          'nome': 'Gaby',
          'email': 'gaby@email.com',
          'senha': 'senha123',
          'dataNascimento': '1998-05-15',
          'genero': 'Feminino',
          'altura': 1.70,
          'peso': 65.0,
          'objetivo': 'Melhorar foco',
          'praticaMeditacao': 0,
          'recebeNotificacoes': 1,
          'condicaoSaude': null,
          'telefone': '82988880000',
          'cidade': 'Maceió',
          'estado': 'AL',
        });
      },
    );
  }

  Future<int> insertUser(UserModel user) async {
    final db = await _getDatabase();
    return await db.insert('users', user.toMap());
  }

  Future<bool> validateUser(String email, String senha) async {
    final db = await _getDatabase();
    final result = await db.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await _getDatabase();
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }
}
