import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Aqui substitua pelas suas cores
class AppColors {
  static const Color darkGreen5 = Color(0xFF1B5E20);
  static const Color white = Colors.white;
  static const Color greenAccent = Colors.greenAccent;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // Controle dos switches
  bool _darkMode = false;
  bool _notificationsEnabled = true;

  // Páginas simuladas
  final List<Widget> _pages = [
    Center(child: Text('Home Content', style: TextStyle(fontSize: 24))),
    Center(child: Text('Perfil Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Resumo Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkGreen5,
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
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
      title: Text(
        'EQUILIBRE',
        style: GoogleFonts.raleway(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: AppColors.darkGreen5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.darkGreen5),
              child: Text(
                'Configurações',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ExpansionTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: Text('Preferências', style: GoogleFonts.poppins(color: Colors.white)),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white70,
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                SwitchListTile(
                  title: Text('Modo escuro', style: GoogleFonts.poppins(color: Colors.white70)),
                  value: _darkMode,
                  activeColor: AppColors.greenAccent,
                  onChanged: (val) {
                    setState(() {
                      _darkMode = val;
                    });
                    // Aqui você poderia adicionar lógica para tema escuro
                  },
                ),
                SwitchListTile(
                  title: Text('Notificações', style: GoogleFonts.poppins(color: Colors.white70)),
                  value: _notificationsEnabled,
                  activeColor: AppColors.greenAccent,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                    // Controle notificações
                  },
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.info_outline, color: Colors.white),
              title: Text('Sobre', style: GoogleFonts.poppins(color: Colors.white)),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white70,
              childrenPadding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Equilibre v1.0.0\n'
                      'Aplicativo para auxiliar no cuidado do equilíbrio mental e emocional.\n\n'
                      'Desenvolvido por sua equipe, com carinho e dedicação.',
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),

            const Divider(color: Colors.white54, height: 1),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text('Sair', style: GoogleFonts.poppins(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout realizado')),
                );
                // Aqui pode adicionar lógica real para logout
              },
            ),
          ],
        ),
      ),
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
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Resumo'),
      ],
    );
  }
}
