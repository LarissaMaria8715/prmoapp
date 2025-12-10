class Hospital {
  final int id;
  final String nome;
  final String telefone;
  final String endereco;
  final String imagem; // novo campo

  Hospital({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.endereco,
    required this.imagem,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    id: json['id'],
    nome: json['nome'],
    telefone: json['telefone'],
    endereco: json['endereco'],
    imagem: json['imagem'],
  );
}
