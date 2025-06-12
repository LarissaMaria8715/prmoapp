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
      toolbarHeight: 80,
      backgroundColor: AppColors.blueDark,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'EQUILIBRE',
            style: GoogleFonts.jaldi(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: 36,
            color: AppColors.white,
            onPressed: () {
              // ação futura de notificações
            },
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Resumo'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
      ],
    );
  }

  _buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      children: [
        _welcomeCard(),
        const SizedBox(height: 32),
        _actionButtonsGrid(),
        const SizedBox(height: 40),
        _motivationCard(),
        const SizedBox(height: 32),
        _dailyTipCard(),
        const SizedBox(height: 32),
        _quickReflectionCard(),
        const SizedBox(height: 60),
      ],
    );
  }

  _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueDark.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
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
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Cuide do seu equilíbrio mental e emocional',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  _actionButtonsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _actionButton(Icons.sentiment_satisfied_alt, 'Humor', AppColors.accent)),
              const SizedBox(width: 24),
              Expanded(child: _actionButton(Icons.water_drop, 'Hábitos', AppColors.secondary)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _actionButton(Icons.self_improvement, 'Respiração', AppColors.blueLight)),
              const SizedBox(width: 24),
              Expanded(child: _actionButton(Icons.track_changes, 'Metas', AppColors.sand)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _actionButton(Icons.menu_book, 'Diário', AppColors.blueDark)),
              const SizedBox(width: 24),
              Expanded(child: _actionButton(Icons.rocket_launch, 'Motivação', AppColors.sandDark)),
            ],
          ),
        ],
      ),
    );
  }

  _actionButton(IconData icon, String label, Color backgroundColor) {
    return ElevatedButton(
      onPressed: () {
        // Navegação não implementada aqui
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColor,
        shadowColor: backgroundColor.withOpacity(0.4),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _motivationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Motivação do dia',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '"A verdadeira felicidade está no equilíbrio entre mente, corpo e espírito."',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: AppColors.textPrimary.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }

  _dailyTipCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dica do Dia',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Faça uma pausa de 5 minutos para respirar profundamente. Seu cérebro agradece!',
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
  _quickReflectionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.sandDark.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reflexão Rápida',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.sandDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Hoje, o que você fez por você mesmo?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: AppColors.textPrimary.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}