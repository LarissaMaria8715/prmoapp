class Park {
  final String nome;
  final String endereco;
  final double latitude;
  final double longitude;

  Park({
    required this.nome,
    required this.endereco,
    required this.latitude,
    required this.longitude,
  });

  factory Park.fromJson(Map<String, dynamic> json) {
    return Park(
      nome: json['nome'],
      endereco: json['endereco'],
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'endereco': endereco,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
