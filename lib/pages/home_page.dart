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
        backgroundColor: AppColors.fundo,
        appBar: buildAppBar(),
        body: buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            print(index);
          },
          selectedItemColor: Colors.blue,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions_outlined),
              label: 'Humor',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'Hábitos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.air),
              label: 'Respiração',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined),
              label: 'Metas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      toolbarHeight: 75,
      backgroundColor: AppColors.primario,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_outlined,
              color: AppColors.texto
          ),
          SizedBox(width: 8),
          Text(
            'EQUILIBRE',
            style: GoogleFonts.jaldi(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.texto,
            ),
          ),
        ],
      ),
    );
  }

  buildBody() {
    return Center(
      child: Text(
        'Bem-vindo ao app!',
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: AppColors.texto,
        ),
      ),
    );
  }
}
