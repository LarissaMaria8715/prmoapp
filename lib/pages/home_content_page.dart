import 'package:equilibreapp/pages/humor_page.dart';
import 'package:equilibreapp/wigets/style_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white, // Caixa branca como na login
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'EQUILIBRE',
                style: GoogleFonts.raleway(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen5,
                  letterSpacing: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cuide do seu equilíbrio mental e emocional',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppColors.darkGreen5.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              _actionButtonsGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  _actionButtonsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _actionButton(
                Icons.sentiment_satisfied_alt,
                'Humor',
                AppColors.lightBlueDark4,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HumorPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.water_drop,
                'Hábitos',
                AppColors.darkPurple3,
                    () => print('Botão Hábitos clicado'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                Icons.self_improvement,
                'Respiração',
                AppColors.darkGreen3,
                    () => print('Botão Respiração clicado'),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.track_changes,
                'Metas',
                AppColors.darkYellow3,
                    () => print('Botão Metas clicado'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                Icons.menu_book,
                'Diário',
                AppColors.darkRed3,
                    () => print('Botão Diário clicado'),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.rocket_launch,
                'Motivação',
                AppColors.darkOrange2,
                    () => print('Botão Motivação clicado'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                Icons.calendar_month_outlined,
                'Agenda',
                AppColors.darkBordeaux3,
                    () => print('Botão Agenda clicado'),
              ),
            ),
            const SizedBox(width: 30),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  _actionButton(
      IconData icon,
      String label,
      Color backgroundColor,
      VoidCallback onPressed,
      ) {
    return StyleButton(
      icon: icon,
      label: label,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
    );
  }
}
