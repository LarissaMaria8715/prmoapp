import 'package:flutter/material.dart';
import 'package:equilibreapp/utils/colors.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({Key? key}) : super(key: key);

  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final TextEditingController novaMetaController = TextEditingController();
  List<String> metas = [];

  void adicionarMeta() {
    final texto = novaMetaController.text.trim();
    if (texto.isEmpty || metas.contains(texto)) return;
    setState(() => metas.add(texto));
    novaMetaController.clear();
  }

  void atualizarMeta(int index, bool concluida) {
    // Apenas altera a UI, sem persistência
    setState(() {});
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
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
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
                        meta,
                        style: const TextStyle(fontSize: 16),
                      ),
                      value: false,
                      onChanged: (bool? value) {
                        if (value == null) return;
                        atualizarMeta(index, value);
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
