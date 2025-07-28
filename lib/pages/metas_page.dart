import 'package:flutter/material.dart';

class MetasPage extends StatefulWidget {
  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  // Lista de metas com estado (título e se está marcada)
  List<Map<String, dynamic>> metas = [
    {'titulo': 'Correr de manhã', 'concluida': false},
    {'titulo': 'Ler por 30 minutos', 'concluida': false},
    {'titulo': 'Beber 2L de água', 'concluida': false},
    {'titulo': 'Meditar por 10 minutos', 'concluida': false},
    {'titulo': 'Estudar Flutter', 'concluida': false},
    {'titulo': 'Fazer alongamento', 'concluida': false},
    {'titulo': 'Evitar redes sociais por 1h', 'concluida': false},
  ];

  void salvarAlteracoes() {
    // Você pode substituir por lógica de salvar em banco local, por exemplo.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterações salvas com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metas Diárias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: metas.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(metas[index]['titulo']),
                    value: metas[index]['concluida'],
                    onChanged: (bool? value) {
                      setState(() {
                        metas[index]['concluida'] = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: salvarAlteracoes,
              child: Text('Salvar alterações'),
            ),
          ],
        ),
      ),
    );
  }
}