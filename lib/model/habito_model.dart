class Habito {
  int? id;
  int usuarioId;
  String nome;
  String descricao;
  String data;

  Habito({
    this.id,
    required this.usuarioId,
    required this.nome,
    required this.descricao,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'usuario_id': usuarioId,
      'nome': nome,
      'descricao': descricao,
      'data': data,
    };
  }

  factory Habito.fromJson(Map<String, dynamic> json) {
    return Habito(
      id: json['id'],
      usuarioId: json['usuario_id'],
      nome: json['nome'],
      descricao: json['descricao'],
      data: json['data'],
    );
  }
}
