Future<int> insertHabito(Map<String, dynamic> habito) async {
  final db = await initDB();
  return await db.insert('habitos', habito);
}
Future initDB() async {
}

Future<Map<String, dynamic>?> getHabitoByDate(int usuarioId, String data) async {
  final db = await initDB();
  final result = await db.query(
    'habitos',
    where: 'usuario_id = ? AND data = ?',
    whereArgs: [usuarioId, data],
  );
  if (result.isNotEmpty) {
    return result.first;
  }
  return null;
}

Future<List<Map<String, dynamic>>> getHabitosUsuario(int usuarioId) async {
  final db = await initDB();
  return await db.query(
    'habitos',
    where: 'usuario_id = ?',
    whereArgs: [usuarioId],
    orderBy: 'data DESC',
  );
}