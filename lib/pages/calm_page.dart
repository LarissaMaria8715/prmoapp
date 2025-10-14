import 'dart:math';
import 'package:flutter/material.dart';
import '../database/imagem_dao.dart';
import '../model/imagem_model.dart';

class CalmaPage extends StatefulWidget {
  const CalmaPage({Key? key}) : super(key: key);

  @override
  State<CalmaPage> createState() => _CalmaPageState();
}

class _CalmaPageState extends State<CalmaPage> {
  final ImagemDao dao = ImagemDao();
  List<ImagemModel> imagens = [];
  ImagemModel? imagemAtual;
  String fraseAtual = "";
  bool carregando = true;

  final List<String> frases = [
    "Respire fundo e sinta a calma do momento.",
    "A paz começa dentro de você.",
    "Hoje é um bom dia para relaxar.",
    "Deixe a mente silenciar por um instante.",
    "A natureza fala em silêncio."
  ];

  @override
  void initState() {
    super.initState();
    carregarImagens();
  }

  Future<void> carregarImagens() async {
    setState(() => carregando = true);
    try {
      imagens = await dao.obterImagens();
      novaImagem();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar imagens')),
      );
    } finally {
      setState(() => carregando = false);
    }
  }

  void novaImagem() {
    if (imagens.isNotEmpty) {
      setState(() {
        imagemAtual = imagens[Random().nextInt(imagens.length)];
        fraseAtual = frases[Random().nextInt(frases.length)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: carregando
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : imagemAtual == null
            ? const Center(child: Text("Nenhuma imagem carregada", style: TextStyle(color: Colors.white)))
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                imagemAtual!.downloadUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              fraseAtual,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: novaImagem,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text("Nova imagem"),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
