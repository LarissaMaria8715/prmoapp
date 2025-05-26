import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.fundo,
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Página Inicial',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.texto,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primario,
      elevation: 0,
    );
  }

  Widget buildBody() {
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
