class Humor {
  int? id;
  int usuarioId;
  String humorLabel;
  String humorEmoji;
  String data;

  Humor({
    this.id,
    required this.usuarioId,
    required this.humorLabel,
    required this.humorEmoji,
    required this.data,
  });

  factory Humor.fromJson(Map<String, dynamic> json) {
    return Humor(
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
      usuarioId: json['usuarioId'] != null ? (json['usuarioId'] as num).toInt() : 1,
      humorLabel: json['humorLabel'] ?? '',
      humorEmoji: json['humorEmoji'] ?? '',
      data: json['data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'humorLabel': humorLabel,
      'humorEmoji': humorEmoji,
      'data': data,
    };
  }
}
