import 'package:sqflite/sqflite.dart';
import '../model/habitos_model.dart';
import 'database_helper.dart';

class HabitoDAO {
  static Future<void> salvarHabito(Habito habito) async {
    final db = await DatabaseHelper().initDB();
    await db.insert('habitos', habito.toMap());
  }

  static Future<List<Habito>> listarHabitos() async {
    final db = await DatabaseHelper().initDB();
    final maps = await db.query('habitos', orderBy: 'data DESC');

    return List.generate(maps.length, (i) {
      return Habito(
        id: maps[i]['id'] as int,
        aguaLitros: maps[i]['aguaLitros'] as double,
        horasSono: maps[i]['horasSono'] as double,
        nivelEstresse: maps[i]['nivelEstresse'] as double,
        tempoTela: maps[i]['tempoTela'] as double,
        tempoAoArLivre: maps[i]['tempoAoArLivre'] as double,
        nivelMotivacao: maps[i]['nivelMotivacao'] as double,
        meditou: maps[i]['meditou'] == 1,
        fezExercicio: maps[i]['fezExercicio'] == 1,
        alimentacaoSaudavel: maps[i]['alimentacaoSaudavel'] == 1,
        comeuFrutas: maps[i]['comeuFrutas'] == 1,
        leuLivro: maps[i]['leuLivro'] == 1,
        teveContatoSocial: maps[i]['teveContatoSocial'] == 1,
        praticouGratidao: maps[i]['praticouGratidao'] == 1,
        autoAvaliacao: maps[i]['autoAvaliacao'] as int,
        observacoes: maps[i]['observacoes'] as String,
        data: maps[i]['data'] as String,
      );
    });
  }
}
