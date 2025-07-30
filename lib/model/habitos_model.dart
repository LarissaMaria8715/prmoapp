class Habito {
  final int? id;
  final double aguaLitros;
  final double horasSono;
  final double nivelEstresse;
  final double tempoTela;
  final double tempoAoArLivre;
  final double nivelMotivacao;
  final bool meditou;
  final bool fezExercicio;
  final bool alimentacaoSaudavel;
  final bool comeuFrutas;
  final bool leuLivro;
  final bool teveContatoSocial;
  final bool praticouGratidao;
  final int autoAvaliacao;
  final String observacoes;
  final String data;

  Habito({
    this.id,
    required this.aguaLitros,
    required this.horasSono,
    required this.nivelEstresse,
    required this.tempoTela,
    required this.tempoAoArLivre,
    required this.nivelMotivacao,
    required this.meditou,
    required this.fezExercicio,
    required this.alimentacaoSaudavel,
    required this.comeuFrutas,
    required this.leuLivro,
    required this.teveContatoSocial,
    required this.praticouGratidao,
    required this.autoAvaliacao,
    required this.observacoes,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'aguaLitros': aguaLitros,
      'horasSono': horasSono,
      'nivelEstresse': nivelEstresse,
      'tempoTela': tempoTela,
      'tempoAoArLivre': tempoAoArLivre,
      'nivelMotivacao': nivelMotivacao,
      'meditou': meditou ? 1 : 0,
      'fezExercicio': fezExercicio ? 1 : 0,
      'alimentacaoSaudavel': alimentacaoSaudavel ? 1 : 0,
      'comeuFrutas': comeuFrutas ? 1 : 0,
      'leuLivro': leuLivro ? 1 : 0,
      'teveContatoSocial': teveContatoSocial ? 1 : 0,
      'praticouGratidao': praticouGratidao ? 1 : 0,
      'autoAvaliacao': autoAvaliacao,
      'observacoes': observacoes,
      'data': data,
    };
  }
}
