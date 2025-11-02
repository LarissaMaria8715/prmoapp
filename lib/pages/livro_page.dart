import 'package:flutter/material.dart';
import '../api/livro_api.dart';
import '../model/livro_model.dart';
import '../utils/colors.dart';
import '../wigets/livro_card.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  late Future<List<Livro>> futureLivros;

  @override
  void initState() {
    super.initState();
    futureLivros = _buscarLivros();
  }

  Future<List<Livro>> _buscarLivros() async {
    final data = await LivrosApi.fetchLivrosRaw();
    final List docs = data['docs'] ?? [];

    return docs.map((item) {
      final json = item as Map<String, dynamic>;
      return Livro(
        titulo: json['title'] ?? 'Sem título',
        autor: (json['author_name'] != null && (json['author_name'] as List).isNotEmpty)
            ? json['author_name'][0]
            : 'Autor desconhecido',
        capaUrl: json['cover_i'] != null
            ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
            : 'https://via.placeholder.com/200x300.png?text=Sem+Capa',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Livros',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBrown4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Livro>>(
          future: futureLivros,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Livro> listaLivros = snapshot.requireData;
              return _buildListView(listaLivros);
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Livro> listaLivros) {
    return ListView.builder(
      itemCount: listaLivros.length,
      itemBuilder: (context, i) {
        return LivroCard(livro: listaLivros[i]);
      },
    );
  }
}
