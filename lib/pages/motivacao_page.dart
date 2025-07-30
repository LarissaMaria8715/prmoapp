import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class MotivacaoPage extends StatefulWidget {
  const MotivacaoPage({Key? key}) : super(key: key);

  @override
  State<MotivacaoPage> createState() => _MotivacaoPageState();
}

class _MotivacaoPageState extends State<MotivacaoPage> {
  final List<String> mensagens = [
    "Acredite no seu potencial.",
    "Você é mais forte do que imagina.",
    "Cada dia é uma nova chance de recomeçar.",
    "Pequenos passos também te levam longe.",
    "Não desista, o esforço vale a pena.",
    "Você está exatamente onde precisa estar.",
    "Tudo o que você precisa já está dentro de você.",
    "Confie no processo.",
    "Seja gentil consigo mesmo.",
    "Respire fundo e continue.",
  ];

  late String mensagemAtual;

  @override
  void initState() {
    super.initState();
    _sortearMensagem();
  }

  void _sortearMensagem() {
    final random = Random();
    setState(() {
      mensagemAtual = mensagens[random.nextInt(mensagens.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightOrange0,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.darkOrange4,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Motivação Diária',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_emotions, size: 80, color: AppColors.darkOrange4),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.lightOrange2.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkOrange4.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  '"$mensagemAtual"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: AppColors.darkOrange5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 80), // espaço maior antes do botão
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _sortearMensagem,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    'Nova Mensagem',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkOrange5,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
