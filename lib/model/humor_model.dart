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

  Humor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuarioId = json['usuario_id'];
    humorLabel = json['humorLabel'];
    humorEmoji = json['humorEmoji'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'usuario_id': usuarioId,
      'humorLabel': humorLabel,
      'humorEmoji': humorEmoji,
      'data': data,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}