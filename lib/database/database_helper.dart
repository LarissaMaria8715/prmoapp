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

  Future<void> onCreate(Database db, int version) async {
    // Criação da tabela usuários
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha TEXT NOT NULL,
        dataNascimento TEXT,
        genero TEXT,
        altura REAL,
        peso REAL,
        telefone TEXT,
        cidade TEXT,
        estado TEXT,
        objetivo TEXT,
        praticaMeditacao INTEGER,
        recebeNotificacoes INTEGER,
        condicaoSaude TEXT
      );
    ''');

    // Inserção de usuário teste
    await db.execute('''
      INSERT INTO usuarios (
        nome, email, senha, dataNascimento, genero, altura, peso, objetivo, praticaMeditacao, condicaoSaude, recebeNotificacoes
      ) VALUES (
        'Usuario', 'teste@gmail.com', '123456', '1995-08-06', 'Feminino', 1.65, 60.0, 'Relaxar', 1, '', 1
      );
    ''');

    // Criação da tabela hábitos
    await db.execute('''
      CREATE TABLE habitos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        nome TEXT,
        descricao TEXT,
        data TEXT,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      );
    ''');

    // Criação da tabela humor
    await db.execute('''
      CREATE TABLE humor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        humorLabel TEXT NOT NULL,
        humorEmoji TEXT NOT NULL,
        data TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      );
    ''');

    // Criação da tabela diário
    await db.execute('''
      CREATE TABLE diario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        titulo TEXT,
        conteudo TEXT NOT NULL,
        data TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      );
  
      ''');
  }
}
