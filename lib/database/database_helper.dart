import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'equilibre.db';

    String dbPath = join(path, dbName);
    print("Caminho do banco: $dbPath");

    var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    // Criação da tabela usuários
    String sqlCreateUsuarios = '''
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
    ''';
    await db.execute(sqlCreateUsuarios);

    // Inserindo 1 usuário de exemplo
    String sqlInsertUsuario = """
      INSERT INTO usuarios (
        nome, email, senha, dataNascimento, genero, altura, peso, objetivo, praticaMeditacao, condicaoSaude, recebeNotificacoes
      ) VALUES (
        'Larissa Maria', 'larissa@example.com', '123456', '1995-08-06', 'Feminino', 1.65, 60.0, 'Relaxar', 1, '', 1
      );
    """;
    await db.execute(sqlInsertUsuario);
    print('Usuário inserido com raw SQL!');

    // Criação da tabela hábitos
    String sqlCreateHabitos = '''
      CREATE TABLE habitos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        aguaLitros REAL,
        horasSono REAL,
        nivelEstresse REAL,
        tempoTela REAL,
        tempoAoArLivre REAL,
        nivelMotivacao REAL,
        meditou INTEGER,
        fezExercicio INTEGER,
        alimentacaoSaudavel INTEGER,
        comeuFrutas INTEGER,
        leuLivro INTEGER,
        teveContatoSocial INTEGER,
        praticouGratidao INTEGER,
        autoAvaliacao INTEGER,
        observacoes TEXT,
        data TEXT,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      );
    ''';
    await db.execute(sqlCreateHabitos);

    // Criação da tabela metas
    String sqlCreateMetas = '''
      CREATE TABLE metas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        descricao TEXT NOT NULL,
        concluida INTEGER NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      );
    ''';
    await db.execute(sqlCreateMetas);

    // Criação da tabela humor
    String sqlCreateHumor = '''
      CREATE TABLE humor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        humorLabel TEXT NOT NULL,
        humorEmoji TEXT NOT NULL,
        data TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      );
    ''';
    await db.execute(sqlCreateHumor);
  }
}
