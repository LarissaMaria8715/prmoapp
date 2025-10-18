class Humor {
  int? id;
  late int usuarioId;
  late String humorLabel;
  late String humorEmoji;
  late String data;

  Humor({
    this.id,
    required this.usuarioId,
    required this.humorLabel,
    required this.humorEmoji,
    required this.data,
  });

  Humor.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? (json['id'] as num).toInt() : null,
        usuarioId = json['usuarioId'] != null ? (json['usuarioId'] as num).toInt() : 1,
        humorLabel = json['humorLabel'] ?? '',
        humorEmoji = json['humorEmoji'] ?? '',
        data = json['data'] ?? '';

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
