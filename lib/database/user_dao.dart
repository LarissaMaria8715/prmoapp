import 'package:sqflite/sqflite.dart';           // Biblioteca para manipulação de banco de dados SQLite
import '../model/user_model.dart';               // Modelo de dados do usuário
import 'database_helper.dart';                  // Classe auxiliar para abrir o banco de dados

// Classe responsável pelas operações de acesso ao banco de dados relacionadas ao usuário
class UserDAO {

  // Metodo privado que abre e retorna a instância do banco de dados
  Future<Database> _getDatabase() async {
    return await DatabaseHelper().initDB();      // Chama o mtodo initDB() da classe DatabaseHelper
  }

  // ---------------------------
  // LISTAR TODOS OS USUÁRIOS
  // ---------------------------
  Future<List<UserModel>> listarUsuarios() async {
    final db = await _getDatabase();             // Obtém o banco de dados aberto
    final result = await db.query('usuarios');   // Executa um SELECT * FROM usuarios

    // Converte cada linha do resultado (Map) em um objeto UserModel
    List<UserModel> lista = result.map((json) => UserModel.fromMap(json)).toList();
    return lista;                                // Retorna a lista de usuários
  }

  // ---------------------------
  // INSERIR NOVO USUÁRIO
  // ---------------------------
  Future<int> insertUser(UserModel user) async {
    final db = await _getDatabase();             // Abre o banco
    return await db.insert(                      // Insere na tabela 'usuarios'
      'usuarios',
      user.toMap(),                              // Converte o objeto em um mapa para salvar
    );
  }

  // ---------------------------
  // ATUALIZAR USUÁRIO EXISTENTE
  // ---------------------------
  Future<int> updateUser(UserModel user) async {
    final db = await _getDatabase();             // Abre o banco

    return await db.update(                      // Atualiza a tabela 'usuarios'
      'usuarios',
      user.toMap(),                              // Novos dados do usuário
      where: 'id = ?',                           // Condição WHERE (por ID)
      whereArgs: [user.id],                      // Substitui ? pelo valor do ID
    );
  }

  // ---------------------------
  // VALIDAR LOGIN DO USUÁRIO
  // ---------------------------
  Future<bool> validateUser(String email, String senha) async {
    final db = await _getDatabase();             // Abre o banco

    // Faz uma consulta para verificar se existe um usuário com o email e senha fornecidos
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',          // Condição WHERE com email e senha
      whereArgs: [email, senha],                 // Substitui os ? pelos valores
    );

    return result.isNotEmpty;                    // Retorna true se encontrou o usuário
  }

  // ---------------------------
  // BUSCAR USUÁRIO PELO EMAIL
  // ---------------------------
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await _getDatabase();             // Abre o banco

    final result = await db.query(
      'usuarios',
      where: 'email = ?',                        // Condição WHERE com email
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);    // Converte o resultado em UserModel
    }

    return null;                                 // Retorna null se não encontrou
  }

  // ---------------------------
  // BUSCAR USUÁRIO PELO ID
  // ---------------------------
  Future<UserModel?> getUserById(int id) async {
    final db = await _getDatabase();             // Abre o banco

    final result = await db.query(
      'usuarios',
      where: 'id = ?',                           // Condição WHERE com id
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);    // Converte o resultado em UserModel
    }

    return null;                                 // Retorna null se não encontrou
  }
}
