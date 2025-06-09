import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.sandLight,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      toolbarHeight: 75,
      backgroundColor: AppColors.blueDark,
      elevation: 0,
      centerTitle: true,
      title: _appBarTitle(),
    );
  }

  _appBarTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.self_improvement, size: 38,color: AppColors.white),
        const SizedBox(width: 8),
        Text(
          'EQUILIBRE',
          style: GoogleFonts.jaldi(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          selectedIndex = index;
        });
      },
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.gray.withOpacity(0.7),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Resumo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeCard(),
          const SizedBox(height: 24),
          _actionButtonsRow(),
          const SizedBox(height: 32),
          _motivationCard(),
        ],
      ),
    );
  }

  _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDark.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bem-vindo ao Equilibre',
            style: GoogleFonts.poppins(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cuide do seu equilíbrio mental e emocional',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  _actionButtonsRow() {
    return Center(
      child: Wrap(
        spacing: 50,
        runSpacing: 50,
        alignment: WrapAlignment.center,
        children: [
          _actionButton(Icons.sentiment_satisfied_alt, 'Humor', AppColors.accent),
          _actionButton(Icons.water_drop, 'Hábitos', AppColors.secondary),
          _actionButton(Icons.self_improvement, 'Respiração', AppColors.blueLight),
          _actionButton(Icons.track_changes, 'Metas', AppColors.sand),
          _actionButton(Icons.menu_book, 'Diário', AppColors.blueDark),
          _actionButton(Icons.rocket_launch, 'Motivação', AppColors.sandDark),
        ],
      ),
    );
  }


  _actionButton(IconData icon, String label, Color backgroundColor) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: backgroundColor,
          child: Icon(icon, color: AppColors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  _motivationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Motivação do dia',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"A verdadeira felicidade está no equilíbrio entre mente, corpo e espírito."',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.textPrimary.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
