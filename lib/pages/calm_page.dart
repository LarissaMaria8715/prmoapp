import 'dart:math';
import 'package:flutter/material.dart';
import '../database/imagem_dao.dart';
import '../model/imagem_model.dart';
import '../utils/colors.dart';
import '../wigets/imagem_com_moldura.dart'; // arquivo onde está sua paleta de cores

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
    return Scaffold(
      backgroundColor: AppColors.lightWine1,
      appBar: AppBar(
        title: const Text(
          "Momento de Calma",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.wine,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: carregando
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : imagemAtual == null
            ? const Center(
          child: Text(
            "Nenhuma imagem carregada",
            style: TextStyle(color: Colors.white),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ImagemComMoldura(imagemUrl: imagemAtual!.downloadUrl),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                fraseAtual,
                style: const TextStyle(
                  color: AppColors.wine,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: novaImagem,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightWine3,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),

              icon: const Icon(Icons.refresh),
              label: const Text("Solicitar nova foto"),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
