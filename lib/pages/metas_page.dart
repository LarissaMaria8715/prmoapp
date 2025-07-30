import 'package:flutter/material.dart';
import 'package:equilibreapp/utils/colors.dart';
import '../database/database_helper.dart';
import '../model/meta_model.dart';

class MetasPage extends StatefulWidget {
  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  List<Meta> metas = [];
  final TextEditingController novaMetaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarMetas();
  }

  Future<void> _carregarMetas() async {
    final db = await DatabaseHelper().initDB();
    final List<Map<String, dynamic>> maps = await db.query('metas');
    setState(() {
      metas = List.generate(maps.length, (i) => Meta.fromMap(maps[i]));
    });
  }

  Future<void> adicionarMeta() async {
    final texto = novaMetaController.text.trim();
    if (texto.isNotEmpty && !metas.any((meta) => meta.descricao == texto)) {
      final novaMeta = Meta(descricao: texto, concluida: false);
      final db = await DatabaseHelper().initDB();
      novaMeta.id = await db.insert('metas', novaMeta.toMap());
      setState(() {
        metas.add(novaMeta);
        novaMetaController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma meta válida e única!')),
      );
    }
  }

  Future<void> atualizarMeta(Meta meta) async {
    final db = await DatabaseHelper().initDB();
    await db.update(
      'metas',
      {'concluida': meta.concluida ? 1 : 0},
      where: 'id = ?',
      whereArgs: [meta.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Metas Diárias',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.darkYellow3,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Adicionar Nova Meta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkYellow3,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: novaMetaController,
                    decoration: const InputDecoration(
                      hintText: 'Ex: Estudar 1h hoje',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: adicionarMeta,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkYellow3,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Minhas Metas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkYellow3,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: metas.isEmpty
                  ? const Center(child: Text('Nenhuma meta cadastrada ainda.'))
                  : ListView.builder(
                itemCount: metas.length,
                itemBuilder: (context, index) {
                  final meta = metas[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        meta.descricao,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: meta.concluida ? TextDecoration.lineThrough : null,
                          color: meta.concluida ? Colors.grey : Colors.black,
                        ),
                      ),
                      value: meta.concluida,
                      onChanged: (bool? value) {
                        setState(() {
                          meta.concluida = value ?? false;
                        });
                        atualizarMeta(meta);
                      },
                      activeColor: AppColors.darkYellow3,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
