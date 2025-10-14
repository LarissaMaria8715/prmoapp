import 'package:equilibreapp/pages/agenda_page.dart';
import 'package:equilibreapp/pages/habitos_page.dart';
import 'package:equilibreapp/pages/humor_page.dart';
import 'package:equilibreapp/pages/metas_page.dart';
import 'package:equilibreapp/pages/music_page.dart';
import 'package:equilibreapp/pages/respiracao_page.dart';
import 'package:equilibreapp/wigets/style_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../database/user_dao.dart';
import '../utils/colors.dart';
import 'diario_page.dart';
import 'motivacao_page.dart';
import 'livro_page.dart';

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
                    MaterialPageRoute(builder: (context) => HumorPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.water_drop,
                'Hábitos',
                AppColors.purple,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HabitosPage()),
                  );
                },
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
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RespiracaoPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.track_changes,
                'Metas',
                AppColors.darkYellow3,
                    () async {
                  UsuarioDAO userDAO = UsuarioDAO();
                  final usuario = await userDAO.buscarPorEmail(email);

                  if (usuario != null) {
                    final usuarioId = usuario['id'] as int;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MetasPage(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erro: usuário não encontrado.')),
                    );
                  }
                },
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
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiarioPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.rocket_launch,
                'Motivação',
                AppColors.darkOrange2,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MotivacaoPage()),
                  );
                },
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
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgendaPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.backup_table_rounded,
                'Noticias',
                AppColors.darkTerracotta3,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LivrosPage(),
                  )
                  );
                },
              ),
            ),
          ],
        ),


        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: _actionButton(
                Icons.music_note_outlined,
                'Música',
                AppColors.darkGray3,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MusicPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _actionButton(
                Icons.backup_table_rounded,
                'Noticias',
                AppColors.darkTerracotta3,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LivrosPage(),
                      )
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButton(
      IconData icon, String label, Color backgroundColor, VoidCallback onPressed) {
    return StyleButton(
      icon: icon,
      label: label,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
    );
  }
}
