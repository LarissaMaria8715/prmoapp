class Livro {
  final String titulo;
  final String autor;
  final String capaUrl;

  Livro({
    required this.titulo,
    required this.autor,
    required this.capaUrl,
  });

  Livro.fromJson(Map<String, dynamic> json)
      : capaUrl = json['cover_i'] != null
      ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
      : 'https://via.placeholder.com/200x300.png?text=Sem+Capa',
        autor = json['author_name'] != null && (json['author_name'] as List).isNotEmpty
            ? json['author_name'][0]
            : 'Autor desconhecido',
        titulo = json['title'] ?? 'Sem título';
}
