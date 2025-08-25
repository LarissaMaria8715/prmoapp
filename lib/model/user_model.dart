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
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    dataNascimento = json['dataNascimento'];
    genero = json['genero'];
    altura = json['altura'];
    peso = json['peso'];
    objetivo = json['objetivo'];
    praticaMeditacao = json['praticaMeditacao'];
    recebeNotificacoes = json['recebeNotificacoes'];
    condicaoSaude = json['condicaoSaude'];
    telefone = json['telefone'];
    cidade = json['cidade'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != 0) data['id'] = id;
    data['nome'] = nome;
    data['email'] = email;
    data['senha'] = senha;
    data['dataNascimento'] = dataNascimento;
    data['genero'] = genero;
    data['altura'] = altura;
    data['peso'] = peso;
    data['objetivo'] = objetivo;
    data['praticaMeditacao'] = praticaMeditacao;
    data['recebeNotificacoes'] = recebeNotificacoes;
    data['condicaoSaude'] = condicaoSaude;
    data['telefone'] = telefone;
    data['cidade'] = cidade;
    data['estado'] = estado;
    return data;
  }
}
