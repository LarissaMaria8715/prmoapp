import 'package:equilibreapp/pages/agenda/agenda_page.dart';
import 'package:equilibreapp/pages/habits/habitos_page.dart';
import 'package:equilibreapp/pages/humor/humor_page.dart';
import 'package:equilibreapp/pages/goals/metas_page.dart';
import 'package:equilibreapp/pages/music/music_page.dart';
import 'package:equilibreapp/pages/breath/respiracao_page.dart';
import 'package:equilibreapp/wigets/style_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../database/user/user_dao.dart';
import '../../utils/colors.dart';
import '../calm/calm_page.dart';
import '../diary/diario_page.dart';
import '../motivation/motivacao_page.dart';
import '../book/livro_page.dart';

class HomeContent extends StatelessWidget {
  final String email;
  final String senha;

  const HomeContent({Key? key, required this.email, required this.senha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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

  Widget _actionButtonsGrid(BuildContext context) {
    final buttons = [
      _actionButton(Icons.sentiment_satisfied_alt, 'Humor', AppColors.lightBlueDark4, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HumorPage()));
      }),
      _actionButton(Icons.water_drop, 'Hábitos', AppColors.purple, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HabitosPage()));
      }),
      _actionButton(Icons.self_improvement, 'Respiração', AppColors.darkGreen3, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => RespiracaoPage()));
      }),
      _actionButton(Icons.menu_book, 'Diário', AppColors.darkRed3, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DiarioPage()));
      }),
      _actionButton(Icons.rocket_launch, 'Motivação', AppColors.darkOrange2, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MotivacaoPage()));
      }),
      _actionButton(Icons.calendar_month_outlined, 'Agenda', AppColors.darkBordeaux3, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AgendaPage()));
      }),
      _actionButton(Icons.book_outlined, 'Livros', AppColors.darkTerracotta3, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => LivrosPage()));
      }),
      _actionButton(Icons.music_note_outlined, 'Música', AppColors.darkGray3, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MusicPage()));
      }),
      _actionButton(Icons.image_outlined, 'Imagens', AppColors.darkWine1, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CalmaPage()));
      }),
      _actionButton(Icons.image_outlined, 'Lugares', AppColors.darkWine1, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CalmaPage()));
      }),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double spacing = 30;
        int itemsPerRow = 3;
        double totalSpacing = spacing * (itemsPerRow - 1);
        double itemWidth = (constraints.maxWidth - totalSpacing) / itemsPerRow;

        return Wrap(
          spacing: spacing,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: buttons
              .map((button) => SizedBox(
            width: itemWidth,
            child: button,
          ))
              .toList(),
        );
      },
    );
  }

  Widget _actionButton(IconData icon, String label, Color backgroundColor, VoidCallback onPressed) {
    return StyleButton(
      icon: icon,
      label: label,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
    );
  }
}
