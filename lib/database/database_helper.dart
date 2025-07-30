import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'equilibre.db';
    String dbPath = join(path, dbName);

    print("Caminho do banco: $dbPath");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await _onCreate(db, version);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Criação da tabela de usuários
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

    // Criação da tabela de hábitos
    await db.execute('''
      CREATE TABLE habitos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
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
        data TEXT
      );
    ''');

    // Criação da tabela de metas
    await db.execute('''
      CREATE TABLE metas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT NOT NULL,
        concluida INTEGER NOT NULL
      );
    ''');

    // Inserção automática de um usuário padrão
    //não tá inserindo no bd
    await db.insert(
      'usuarios',
      {
        'nome': 'Larissa Maria',
        'email': 'larissa@email.com',
        'senha': '123456',
        'dataNascimento': '2000-01-01',
        'genero': 'Feminino',
        'altura': 1.65,
        'peso': 60.0,
        'telefone': '82999999999',
        'cidade': 'Arapiraca',
        'estado': 'AL',
        'objetivo': 'Melhorar a saúde mental',
        'praticaMeditacao': 1,
        'recebeNotificacoes': 1,
        'condicaoSaude': 'Nenhuma',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
