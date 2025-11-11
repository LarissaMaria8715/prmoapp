class ImagemModel {
  final String id;
  final String author;
  final String url;
  final String downloadUrl;

  ImagemModel({
    required this.id,
    required this.author,
    required this.url,
    required this.downloadUrl,
  });

  factory ImagemModel.fromJson(Map<String, dynamic> json) {
    return ImagemModel(
      id: json['id'].toString(),
      author: json['author'] ?? 'Autor desconhecido',
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }
}