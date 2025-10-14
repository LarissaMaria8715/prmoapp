class Livro {
  final String titulo;
  final String autor;
  final String capaUrl;

  Livro({
    required this.titulo,
    required this.autor,
    required this.capaUrl,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    final capaId = json['cover_i'];
    final capaUrl = capaId != null
        ? 'https://covers.openlibrary.org/b/id/$capaId-L.jpg'
        : 'https://via.placeholder.com/200x300.png?text=Sem+Capa';

    final autor = json['author_name'] != null && (json['author_name'] as List).isNotEmpty
        ? json['author_name'][0]
        : 'Autor desconhecido';

    return Livro(
      titulo: json['title'] ?? 'Sem título',
      autor: autor,
      capaUrl: capaUrl,
    );
  }
}
