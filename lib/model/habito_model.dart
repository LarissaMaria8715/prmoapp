class Habito {
  int? id;
  int usuarioId;
  String nome;
  String descricao; // será JSON
  String data;

  Habito({
    this.id,
    required this.usuarioId,
    required this.nome,
    required this.descricao,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'usuario_id': usuarioId,
      'nome': nome,
      'descricao': descricao,
      'data': data,
    };
    if (id != null) map['id'] = id;
    return map;
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
