import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class HabitoDAO {
  Future<void> salvarHabito(Map<String, dynamic> habito) async {
    Database db = await DatabaseHelper().initDB();
    await db.insert('habitos', habito);
  }

  Future<List<Map<String, dynamic>>> listarHabitos() async {
    List<Map<String, dynamic>> listaHabitos = [];
    Database db = await DatabaseHelper().initDB();

    String sql = 'SELECT * FROM habitos ORDER BY data DESC;';
    var listResult = await db.rawQuery(sql);

    for (var item in listResult) {
      listaHabitos.add(item);
    }

    return listaHabitos;
  }
}
