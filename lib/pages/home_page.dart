import 'package:equilibreapp/pages/perfil_page.dart';
import 'package:equilibreapp/pages/resumo_page.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'home_content_page.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String senha;

  const HomePage({super.key, required this.email, required this.senha});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(email: widget.email, senha: widget.senha),
      PerfilPage(),
      ResumoPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkGreen5,
        appBar: _buildAppBar(),
        body: _pages[selectedIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.darkGreen5,
      centerTitle: true,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 32),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'Menu',
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_active, color: Colors.white, size: 32),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notificações ainda não implementadas')),
            );
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => setState(() => selectedIndex = index),
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.darkGreen5,
      unselectedItemColor: AppColors.darkGreen5.withOpacity(0.5),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Resumo'),
      ],
    );
  }
}
