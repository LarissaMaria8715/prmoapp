class Usuario {
  late int id;
  late String nome;
  late String email;
  late String senha;
  late String dataNascimento;
  late String genero;
  late double altura;
  late double peso;
  late String objetivo;
  late int praticaMeditacao;
  late int recebeNotificacoes;
  late String condicaoSaude;
  late String telefone;
  late String cidade;
  late String estado;
  late String foto;

  Usuario({
    this.id = 0,
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
    required this.condicaoSaude,
    required this.telefone,
    required this.cidade,
    required this.estado,
    this.foto = '',
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nome = json['nome'] ?? '';
    email = json['email'] ?? '';
    senha = json['senha'] ?? '';
    dataNascimento = json['dataNascimento'] ?? '';
    genero = json['genero'] ?? '';

    // ✅ Converte número seguro
    altura = (json['altura'] is int)
        ? (json['altura'] as int).toDouble()
        : (json['altura'] ?? 0.0).toDouble();

    peso = (json['peso'] is int)
        ? (json['peso'] as int).toDouble()
        : (json['peso'] ?? 0.0).toDouble();

    objetivo = json['objetivo'] ?? '';
    praticaMeditacao = json['praticaMeditacao'] ?? 0;
    recebeNotificacoes = json['recebeNotificacoes'] ?? 0;
    condicaoSaude = json['condicaoSaude'] ?? '';
    telefone = json['telefone'] ?? '';
    cidade = json['cidade'] ?? '';
    estado = json['estado'] ?? '';
    foto = json['foto'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'dataNascimento': dataNascimento,
      'genero': genero,
      'altura': altura,
      'peso': peso,
      'objetivo': objetivo,
      'praticaMeditacao': praticaMeditacao,
      'recebeNotificacoes': recebeNotificacoes,
      'condicaoSaude': condicaoSaude,
      'telefone': telefone,
      'cidade': cidade,
      'estado': estado,
      'foto': foto,
    };
  }
}
