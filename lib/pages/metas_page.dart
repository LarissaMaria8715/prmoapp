import 'package:flutter/material.dart';
import 'package:equilibreapp/utils/colors.dart';
import '../database/meta_dao.dart';

class MetasPage extends StatefulWidget {
  final int usuarioId;

  const MetasPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  List<Map<String, dynamic>> metas = [];
  final TextEditingController novaMetaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarMetas();
  }

  Future<void> _carregarMetas() async {
    List<Map<String, dynamic>> todasMetas = await MetaDAO.listarMetas();
    // Filtrar as metas do usuário atual
    final usuarioMetas = todasMetas.where((m) => m['usuario_id'] == widget.usuarioId).toList();

    setState(() {
      metas = usuarioMetas;
    });
  }

  Future<void> adicionarMeta() async {
    final texto = novaMetaController.text.trim();
    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma meta válida!')),
      );
      return;
    }
    if (metas.any((meta) => meta['descricao'] == texto)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meta já cadastrada!')),
      );
      return;
    }

    Map<String, dynamic> novaMeta = {
      'usuario_id': widget.usuarioId,
      'descricao': texto,
      'concluida': 0,
    };

    await MetaDAO.inserirMeta(novaMeta);
    novaMetaController.clear();
    await _carregarMetas();
  }

  Future<void> atualizarMeta(Map<String, dynamic> meta, bool concluida) async {
    meta['concluida'] = concluida ? 1 : 0;
    await MetaDAO.atualizarMeta(meta);
    await _carregarMetas();
  }

  @override
  void dispose() {
    novaMetaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Metas Diárias',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                  final concluida = meta['concluida'] == 1;
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        meta['descricao'] ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: concluida
                              ? TextDecoration.lineThrough
                              : null,
                          color: concluida ? Colors.grey : Colors.black,
                        ),
                      ),
                      value: concluida,
                      onChanged: (bool? value) {
                        if (value == null) return;
                        atualizarMeta(meta, value);
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
