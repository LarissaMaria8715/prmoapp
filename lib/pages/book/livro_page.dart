import 'package:flutter/material.dart';
import '../../api/book/livro_api.dart';
import '../../model/book/livro_model.dart';
import '../../utils/colors.dart';
import '../../wigets/book/livro_card.dart';
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
    futureLivros = LivrosApi().listarLivros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBrown1,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Livro>>(
          future: futureLivros,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final livros = snapshot.requireData;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: livros.isEmpty
                        ? _buildEmptyMessage()
                        : ListView.builder(
                      itemCount: livros.length,
                      itemBuilder: (context, index) {
                        return LivroCard(livro: livros[index]);
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.lightBlueDark4,
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: AppColors.darkBrown4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Livros',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildTitle(String text, {double size = 35}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlueDark4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        "Nenhum livro encontrado.",
        style: TextStyle(fontSize: 16, color: AppColors.lightBlueDark4),
      ),
    );
  }
}
