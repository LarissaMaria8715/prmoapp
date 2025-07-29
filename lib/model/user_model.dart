class UserModel {
  final int? id;
  final String nome;
  final String email;
  final String senha;
  final String dataNascimento;
  final String genero;
  final double altura;
  final double peso;
  final String objetivo;
  final bool praticaMeditacao;
  final bool recebeNotificacoes;
  final String? condicaoSaude;
  final String? telefone;
  final String? cidade;
  final String? estado;

  UserModel({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.dataNascimento,
    required this.genero,
    required this.altura,
    required this.peso,
    required this.objetivo,
    required this.praticaMeditacao,
    required this.recebeNotificacoes,
    this.condicaoSaude,
    this.telefone,
    this.cidade,
    this.estado,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'data_nascimento': dataNascimento,
      'genero': genero,
      'altura': altura,
      'peso': peso,
      'objetivo': objetivo,
      'praticaMeditacao': praticaMeditacao ? 1 : 0,
      'recebeNotificacoes': recebeNotificacoes ? 1 : 0,
      'condicaoSaude': condicaoSaude,
      'telefone': telefone,
      'cidade': cidade,
      'estado': estado,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      dataNascimento: map['dataNascimento'],
      genero: map['genero'],
      altura: map['altura'],
      peso: map['peso'],
      objetivo: map['objetivo'],
      praticaMeditacao: map['praticaMeditacao'] == 1,
      recebeNotificacoes: map['recebeNotificacoes'] == 1,
      condicaoSaude: map['condicaoSaude'],
      telefone: map['telefone'],
      cidade: map['cidade'],
      estado: map['estado'],
    );
  }
}
