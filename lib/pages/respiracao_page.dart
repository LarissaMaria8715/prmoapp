import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class RespiracaoPage extends StatefulWidget {
  const RespiracaoPage({super.key});

  @override
  State<RespiracaoPage> createState() => _RespiracaoPageState();
}

class _RespiracaoPageState extends State<RespiracaoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;
  int _remainingSeconds = 60;
  String _status = "Inspire";
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
        setState(() => _status = "Expire");
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
        setState(() => _status = "Inspire");
      }
    });
    _animation = Tween<double>(begin: 100, end: 220).animate(_controller);
  }

  void iniciarAnimacao() {
    _controller.forward();
    _isAnimating = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        _pararAnimacao();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _pararAnimacao() {
    _timer?.cancel();
    _controller.stop();
    _isAnimating = false;
  }

  void _reiniciar() {
    _pararAnimacao();
    setState(() {
      _remainingSeconds = 60;
      _status = "Inspire";
    });
    iniciarAnimacao();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
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
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkGreen3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _status,
              style: GoogleFonts.lato(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen3,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => Container(
                    width: _animation.value,
                    height: _animation.value,
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen3.withOpacity(0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkGreen3.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Tempo restante: $_remainingSeconds s",
              style: GoogleFonts.lato(
                fontSize: 18,
                color: AppColors.darkGreen3.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _reiniciar,
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
                backgroundColor: AppColors.darkGreen3,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _remainingSeconds = 60;
                });
                iniciarAnimacao();
              },
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: Text(
                "Começar",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen2,
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
