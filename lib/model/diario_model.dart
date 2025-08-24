class Diario {
  int? id;
  int usuarioId;
  String titulo;
  String conteudo;
  String data;

  Diario({
    this.id,
    required this.usuarioId,
    required this.titulo,
    required this.conteudo,
    required this.data,
  });

  // Converter um objeto Diario para Map (para salvar no SQLite)
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

  // Criar um objeto Diario a partir de Map (do SQLite)
  factory Diario.fromJson(Map<String, dynamic> json) {
    return Diario(
      id: json['id'],
      usuarioId: json['usuario_id'],
      titulo: json['titulo'],
      conteudo: json['conteudo'],
      data: json['data'],
    );
  }
}
