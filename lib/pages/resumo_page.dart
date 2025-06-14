import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResumoPage extends StatelessWidget {
  const ResumoPage({super.key});

  static const Color primaryVariant = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Sem ação

            },
          ),
          title: Text(
            'Resumo da Semana',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryVariant,
          centerTitle: true,
          toolbarHeight: 80, // Altura aumentada
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryVariant,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Resumo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildResumoBox(
                title: "Humor Médio",
                value: "😊 Feliz",
                comentario: "Seu humor melhorou na quarta-feira!",
              ),
              const SizedBox(height: 16),
              _buildResumoBox(
                title: "Água Consumida",
                value: "12L",
                comentario: "Excelente hidratação esta semana!",
              ),
              const SizedBox(height: 16),
              _buildResumoBox(
                title: "Sono Médio",
                value: "7h 30min",
                comentario: "Boa média de sono!",
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  'Atualizar Dados',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryVariant,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResumoBox({
    required String title,
    required String value,
    required String comentario,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryVariant.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: primaryVariant),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            comentario,
            style: GoogleFonts.lato(
              fontSize: 14,
              color: primaryVariant.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
