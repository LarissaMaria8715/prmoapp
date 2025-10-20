class Habito {
  int? id;
  int usuarioId;
  String nome;
  String descricao; // JSON com os dados dos hábitos (água, sono etc.)
  String data;
  String? frequencia; // opcional

  Habito({
    this.id,
    required this.usuarioId,
    required this.nome,
    required this.descricao,
    required this.data,
    this.frequencia,
  });

  /// Cria um objeto a partir de um JSON/Map (vindo da API ou do banco)
  Habito.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? json['id'] as int : null,
        usuarioId = json['usuarioId'] is int
            ? json['usuarioId']
            : int.tryParse(json['usuarioId']?.toString() ?? '0') ?? 0,
        nome = json['nome']?.toString() ?? 'Sem nome',
        descricao = json['descricao']?.toString() ?? '{}',
        data = json['data']?.toString() ?? DateTime.now().toIso8601String(),
        frequencia = json['frequencia']?.toString();

  /// Converte o objeto para JSON/Map (para salvar no banco)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'nome': nome,
      'descricao': descricao,
      'data': data,
      'frequencia': frequencia,
    };
  }

  /// Exibição legível para debug/log
  @override
  String toString() {
    return 'Habito{id: $id, usuarioId: $usuarioId, nome: $nome, data: $data, frequencia: $frequencia}';
  }
}
