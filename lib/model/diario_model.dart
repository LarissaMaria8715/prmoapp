class Diario {
  final int? id;
  final int usuarioId;
  final String titulo;
  final String conteudo;
  final String data;

  Diario({
    this.id,
    required this.usuarioId,
    required this.titulo,
    required this.conteudo,
    required this.data,
  });

  factory Diario.fromJson(Map<String, dynamic> json) {
    return Diario(
      id: json['id'],
      usuarioId: json['usuarioId'] ?? json['usuario_id'] ?? 1, // compatível com API e DB
      titulo: json['titulo'] ?? '',
      conteudo: json['conteudo'] ?? json['texto'] ?? '', // API = texto, DB = conteudo
      data: json['data'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    // usado para salvar no banco local (SQLite)
    return {
      'usuario_id': usuarioId, // agora corresponde ao banco
      'titulo': titulo,
      'conteudo': conteudo,
      'data': data,
    };
  }

  Map<String, dynamic> toJsonForApi() {
    // usado caso queira enviar para API
    return {
      'usuarioId': usuarioId,
      'titulo': titulo,
      'texto': conteudo,
      'data': data,
    };
  }
}
