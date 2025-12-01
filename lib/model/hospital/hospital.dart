class Hospital {
  final int id;
  final String nome;
  final String endereco;
  final String telefone;
  final String foto;

  Hospital({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
    required this.foto, required double latitude, required double longitude,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      nome: json['nome'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      foto: json['foto'],
    );
  }
}
