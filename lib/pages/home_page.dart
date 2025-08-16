import 'package:equilibreapp/pages/perfil_page.dart';
import 'package:equilibreapp/pages/resumo_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Controle dos switches
  bool _darkMode = false;
  bool _notificationsEnabled = true;

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
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // 🔹 Preferências
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
                    activeColor: AppColors.lightOrange1,
                    onChanged: (val) {
                      setState(() {
                        _darkMode = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Notificações', style: GoogleFonts.poppins(color: Colors.white70)),
                    value: _notificationsEnabled,
                    activeColor: AppColors.lightOrange1,
                    onChanged: (val) {
                      setState(() {
                        _notificationsEnabled = val;
                      });
                      // lógica para habilitar/desabilitar notificações
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 🔹 Privacidade e Segurança
              ExpansionTile(
                leading: const Icon(Icons.lock_outline, color: Colors.white),
                title: Text('Privacidade e Segurança', style: GoogleFonts.poppins(color: Colors.white)),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  ListTile(
                    leading: const Icon(Icons.security, color: Colors.white70),
                    title: Text('Política de Privacidade', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // abrir tela de política
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                    title: Text('Excluir Conta', style: GoogleFonts.poppins(color: Colors.redAccent)),
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirmar exclusão"),
                          content: const Text("Deseja realmente excluir sua conta e todos os dados?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        // lógica real para exclusão de conta
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Conta excluída com sucesso.")),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 🔹 Dados e Sincronização
              ExpansionTile(
                leading: const Icon(Icons.sync, color: Colors.white),
                title: Text('Dados e Sincronização', style: GoogleFonts.poppins(color: Colors.white)),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  ListTile(
                    leading: const Icon(Icons.backup, color: Colors.white70),
                    title: Text('Backup de dados', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // lógica de backup
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.restore, color: Colors.white70),
                    title: Text('Restaurar dados', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // lógica de restauração
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.cleaning_services, color: Colors.white70),
                    title: Text('Limpar histórico', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // lógica para limpar dados locais
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 🔹 Idioma e Região
              ExpansionTile(
                leading: const Icon(Icons.language, color: Colors.white),
                title: Text('Idioma e Região', style: GoogleFonts.poppins(color: Colors.white)),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  ListTile(
                    leading: const Icon(Icons.translate, color: Colors.white70),
                    title: Text('Idioma', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // selecionar idioma
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.white70),
                    title: Text('Formato de data', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // escolher formato de data
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 🔹 Ajuda e Suporte
              ExpansionTile(
                leading: const Icon(Icons.help_outline, color: Colors.white),
                title: Text('Ajuda e Suporte', style: GoogleFonts.poppins(color: Colors.white)),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.all(16),
                children: [
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.white70),
                    title: Text('Tutorial de uso', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // abrir tutorial
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_answer, color: Colors.white70),
                    title: Text('FAQ', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // abrir FAQ
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined, color: Colors.white70),
                    title: Text('Contato/Suporte', style: GoogleFonts.poppins(color: Colors.white70)),
                    onTap: () {
                      // abrir suporte
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 🔹 Sobre
              ExpansionTile(
                leading: const Icon(Icons.info_outline, color: Colors.white),
                title: Text('Sobre', style: GoogleFonts.poppins(color: Colors.white)),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Equilibre v1.0.0\n'
                        'Aplicativo para auxiliar no cuidado do equilíbrio mental e emocional.\n',
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 🔹 Desenvolvedores
              ExpansionTile(
                leading: const Icon(Icons.group, color: Colors.white),
                title: Text('Desenvolvedores', style: GoogleFonts.poppins(color: Colors.white)),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white70,
                childrenPadding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Desenvolvido por:\n'
                        '- Ayslanne Gonzaga\n'
                        '- Larissa Maria\n'
                        '- Lyvia Maria\n'
                        '- Maria Gabriely\n',
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

              const Divider(color: Colors.white54, height: 1),

              // 🔹 Logout
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: Text('Sair', style: GoogleFonts.poppins(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout realizado')),
                  );
                  // lógica de logout real
                },
              ),
            ]


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
