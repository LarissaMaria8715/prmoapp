import 'package:flutter/material.dart';
import '../database/livro_dao.dart';
import '../model/livro_model.dart';
import '../wigets/livro_card.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  List<Livro> _livros = [];
  bool _isLoading = true;
  String? _erroMsg;

  @override
  void initState() {
    super.initState();
    _carregarLivros();
  }

  Future<void> _carregarLivros() async {
    setState(() {
      _isLoading = true;
      _erroMsg = null;
    });

    try {
      final livros = await LivroDao.getLivros();
      setState(() {
        _livros = livros;
      });
    } catch (e) {
      setState(() {
        _erroMsg = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros em Português'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _erroMsg != null
            ? Center(child: Text(_erroMsg!))
            : ListView.separated(
          itemCount: _livros.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final livro = _livros[index];
            return LivroCard(livro: livro);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarLivros,
        backgroundColor: Colors.brown,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}



