class Habito {
  int? id;
  int usuarioId;
  String nome;
  String descricao;
  String data;
  String? frequencia;

  Habito({
    this.id,
    required this.usuarioId,
    required this.nome,
    required this.descricao,
    required this.data,
    this.frequencia,
  });

  factory Habito.fromJson(Map<String, dynamic> json) {
    return Habito(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}'),
      usuarioId: json['usuarioId'] is int
          ? json['usuarioId']
          : int.tryParse('${json['usuarioId']}') ?? 0,
      nome: json['nome'] ?? 'Sem nome',
      descricao: json['descricao'] ?? '{}',
      data: json['data'] ?? DateTime.now().toIso8601String(),
      frequencia: json['frequencia'],
    );
  }

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
}
