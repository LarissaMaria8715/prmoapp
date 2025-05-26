import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, this.userName = "Usuário"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundo,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Olá, $userName',
          style: GoogleFonts.roboto(
            color: AppColors.texto,
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        backgroundColor: AppColors.primario,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Resumo do dia',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.texto,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 140,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secundario.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.mood, size: 32, color: AppColors.primario),
                    Text("Feliz", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: AppColors.texto,
                    )),
                    Text("Hoje", style: GoogleFonts.roboto(color: AppColors.texto)),
                  ],
                ),
              ),
              Container(
                width: 140,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secundario.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.mood_bad, size: 32, color: AppColors.primario),
                    Text("Triste", style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: AppColors.texto,
                    )),
                    Text("Ontem", style: GoogleFonts.roboto(color: AppColors.texto)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Módulos',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.texto,
            ),
          ),
          const SizedBox(height: 12),
          _buildTile(
            context,
            icon: Icons.emoji_emotions,
            title: 'Humor',
            subtitle: 'Como você se sente hoje?',
            route: '/humor',
          ),
          _buildTile(
            context,
            icon: Icons.spa,
            title: 'Respiração',
            subtitle: 'Exercícios para relaxar',
            route: '/respiracao',
          ),
          _buildTile(
            context,
            icon: Icons.check_circle,
            title: 'Metas',
            subtitle: 'Defina seus objetivos',
            route: '/metas',
          ),
          _buildTile(
            context,
            icon: Icons.water_drop,
            title: 'Hábitos',
            subtitle: 'Sono e água',
            route: '/habitos',
          ),
          _buildTile(
            context,
            icon: Icons.book,
            title: 'Diário',
            subtitle: 'Registre seus pensamentos',
            route: '/diario',
          ),
          _buildTile(
            context,
            icon: Icons.bolt,
            title: 'Motivação',
            subtitle: 'Frase do dia',
            route: '/motivacao',
          ),
        ],
      ),
    );
  }

  _buildTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required String route}) {
    return ListTile(
      leading: Icon(
          icon,
          color: AppColors.primario
      ),
      title: Text(
          title,
          style: GoogleFonts.roboto(
              color: AppColors.texto
          )),
      subtitle: Text(
          subtitle,
          style: GoogleFonts.roboto(
              color: AppColors.texto.withOpacity(0.7)
          )),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
