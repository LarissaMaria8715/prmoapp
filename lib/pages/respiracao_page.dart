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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text(
          'Respiração Consciente',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.blueLight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            // Navegação futura
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _faseTexto,
              style: GoogleFonts.lato(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.blueDark,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 4),
                  width: _tamanhoCirculo,
                  height: _tamanhoCirculo,
                  decoration: BoxDecoration(
                    color: AppColors.blueLight.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Text(
              "Tempo restante: $_tempoRestante s",
              style: GoogleFonts.lato(
                fontSize: 18,
                color: AppColors.blueDark.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _reiniciarPratica,
              icon: const Icon(Icons.replay, color: Colors.white),
              label: Text(
                "Reiniciar",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueLight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

