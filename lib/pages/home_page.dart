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
        backgroundColor: AppColors.lightBlue1,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      toolbarHeight: 90,
      backgroundColor: AppColors.darkPurple5,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'EQUILIBRE',
            style: GoogleFonts.rubik(
              fontSize: 36,
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
      backgroundColor: AppColors.darkPurple5,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.lightPurple1.withOpacity(0.7),
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
      ],
    );
  }

  _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkBlueDark1,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBlueDark1.withOpacity(0.3),
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
              Expanded(child: _actionButton(Icons.sentiment_satisfied_alt, 'Humor', AppColors.lightBlueDark4)),
              const SizedBox(width: 30),
              Expanded(child: _actionButton(Icons.water_drop, 'Hábitos', AppColors.darkPurple3)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _actionButton(Icons.self_improvement, 'Respiração', AppColors.darkGreen3)),
              const SizedBox(width: 30),
              Expanded(child: _actionButton(Icons.track_changes, 'Metas', AppColors.darkYellow3)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _actionButton(Icons.menu_book, 'Diário', AppColors.darkRed3)),
              const SizedBox(width: 30),
              Expanded(child: _actionButton(Icons.rocket_launch, 'Motivação', AppColors.darkOrange2)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _actionButton(Icons.calendar_month_outlined, 'Agenda', AppColors.darkBordeaux3)),
              const SizedBox(width: 30),
              Expanded(child: Container()),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              icon,
              color: Colors.white,
              size: 60
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}