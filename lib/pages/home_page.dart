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
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      title: Text(
        'Olá, $userName',
        style: GoogleFonts.lato(
          color: AppColors.texto,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
      ),
      backgroundColor: AppColors.primario,
    );
  }

  _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('Resumo do dia'),
        const SizedBox(height: 16),
        _buildResumoCards(),
        const SizedBox(height: 24),
        _buildSectionTitle('Módulos'),
        const SizedBox(height: 12),
        _buildTile(context, icon: Icons.emoji_emotions, title: 'Humor', subtitle: 'Como você se sente hoje?', route: '/humor'),
        _buildTile(context, icon: Icons.spa, title: 'Respiração', subtitle: 'Exercícios para relaxar', route: '/respiracao'),
        _buildTile(context, icon: Icons.check_circle, title: 'Metas', subtitle: 'Defina seus objetivos', route: '/metas'),
        _buildTile(context, icon: Icons.water_drop, title: 'Hábitos', subtitle: 'Sono e água', route: '/habitos'),
        _buildTile(context, icon: Icons.book, title: 'Diário', subtitle: 'Registre seus pensamentos', route: '/diario'),
        _buildTile(context, icon: Icons.bolt, title: 'Motivação', subtitle: 'Frase do dia', route: '/motivacao'),
      ],
    );
  }

  _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.texto,
      ),
    );
  }

  _buildResumoCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildResumoCard(icon: Icons.mood, title: "Feliz", subtitle: "Hoje"),
        _buildResumoCard(icon: Icons.mood_bad, title: "Triste", subtitle: "Ontem"),
      ],
    );
  }

  _buildResumoCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secundario.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.primario),
          Text(
            title,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              color: AppColors.texto,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.lato(color: AppColors.texto),
          ),
        ],
      ),
    );
  }

  _buildTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required String route}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primario),
      title: Text(
        title,
        style: GoogleFonts.lato(color: AppColors.texto),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.lato(color: AppColors.texto.withOpacity(0.7)),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
