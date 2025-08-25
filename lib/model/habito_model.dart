class Habito {
  late int? id;
  late int usuarioId;
  late String nome;
  late String descricao;
  late String data;

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

   Habito.fromJson(Map<String, dynamic> json) {
      id =  json['id'];
      usuarioId = json['usuario_id'];
      nome = json['nome'];
      descricao = json['descricao'];
      data = json['data'];
  }
}
