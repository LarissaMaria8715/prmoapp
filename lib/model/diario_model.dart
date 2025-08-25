class Diario {
  late int? id;
  late int usuarioId;
  late String titulo;
  late String conteudo;
  late String data;

  Diario({
    this.id,
    required this.usuarioId,
    required this.titulo,
    required this.conteudo,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'usuario_id': usuarioId,
      'titulo': titulo,
      'conteudo': conteudo,
      'data': data,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

   Diario.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      usuarioId = json['usuario_id'];
      titulo = json['titulo'];
      conteudo = json['conteudo'];
      data = json['data'];
  }
}
