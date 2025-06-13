import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
class RespiracaoPage extends StatefulWidget {
  const RespiracaoPage({super.key});

  @override
  State<RespiracaoPage> createState() => _RespiracaoPageState();
}

class _RespiracaoPageState extends State<RespiracaoPage> {
  bool _expandindo = true;
  String _faseTexto = "Inspire";
  double _tamanhoCirculo = 150;
  Timer? _animacaoTimer;
  Timer? _cronometro;
  int _tempoRestante = 60;
  final int _tempoInicial = 60;

  @override
  void initState() {
    super.initState();
    _iniciarAnimacao();
    _iniciarCronometro();
  }

  void _iniciarAnimacao() {
    _animacaoTimer?.cancel();
    _animacaoTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _expandindo = !_expandindo;
        _faseTexto = _expandindo ? "Inspire" : "Expire";
        _tamanhoCirculo = _expandindo ? 220 : 150;
      });
    });
  }

  void _iniciarCronometro() {
    _cronometro?.cancel();
    _cronometro = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_tempoRestante > 0) {
          _tempoRestante--;
        } else {
          _animacaoTimer?.cancel();
          _cronometro?.cancel();
          _faseTexto = "Concluído";
        }
      });
    });
  }

  void _reiniciarPratica() {
    setState(() {
      _tempoRestante = _tempoInicial;
      _faseTexto = "Inspire";
      _expandindo = true;
      _tamanhoCirculo = 150;
    });
    _iniciarAnimacao();
    _iniciarCronometro();
  }

  @override
  void dispose() {
    _animacaoTimer?.cancel();
    _cronometro?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Respiração Consciente',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _faseTexto,
              style: GoogleFonts.lato(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 40),
            AnimatedContainer(
              duration: const Duration(seconds: 4),
              width: _tamanhoCirculo,
              height: _tamanhoCirculo,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Tempo restante: $_tempoRestante s",
              style: GoogleFonts.lato(
                fontSize: 18,
                color: AppColors.accent.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _reiniciarPratica,
              icon: const Icon(Icons.replay, color: AppColors.white),
              label: Text(
                "Reiniciar",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

