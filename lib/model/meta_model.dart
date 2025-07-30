class Meta {
  int? id;
  String descricao;
  bool concluida;

  Meta({this.id, required this.descricao, required this.concluida});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'concluida': concluida ? 1 : 0,
    };
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      id: map['id'],
      descricao: map['descricao'],
      concluida: map['concluida'] == 1,
    );
  }
}
