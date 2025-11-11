class Music {
  final String trackName;
  final String artistName;
  final String artworkUrl;
  final String previewUrl;

  Music({
    required this.trackName,
    required this.artistName,
    required this.artworkUrl,
    required this.previewUrl,
  });

  // Parse da Deezer API
  factory Music.fromJsonDeezer(Map<String, dynamic> json) {
    return Music(
      trackName: json['title']?.toString() ?? 'Sem título',
      artistName: json['artist']?['name']?.toString() ?? 'Desconhecido',
      artworkUrl: json['album']?['cover_medium']?.toString() ??
          'https://via.placeholder.com/100x100.png?text=Sem+Imagem',
      previewUrl: json['preview']?.toString() ?? '',
    );
  }
}
