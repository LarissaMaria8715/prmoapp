import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'equilibre.db';
    String dbPath = join(path, dbName);

    print("Caminho do banco: $dbPath");

    var db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );

    return db;
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE humor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT,
        emoji TEXT,
        humor TEXT,
        descricao TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE agenda (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT,
        data TEXT,
        hora TEXT,
        concluido INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE diario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT,
        titulo TEXT,
        conteudo TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE habitos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        frequencia TEXT,
        ultimo_registro TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE metas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT,
        data_limite TEXT,
        concluida INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE motivacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT,
        conteudo TEXT,
        favorito INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE respiracoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT,
        duracao INTEGER,
        tipo TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE configuracoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tema TEXT,
        notificacoes INTEGER DEFAULT 1
      );
    ''');
  }
}
