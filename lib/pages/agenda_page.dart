import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const fundo = Color(0xFFF7F9F9);
  static const primario = Color(0xFF4A8C82);
  static const secundario = Color(0xFF89B6A5);
  static const destaque = Color(0xFFE5C07B);
  static const texto = Color(0xFF2F3E46);
  static const alerta = Color(0xFFE57373);
}

class AgendaPage extends StatelessWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.fundo,
        appBar: AppBar(
          backgroundColor: AppColors.primario,
          title: Text(
            'Agenda',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Seus Compromissos de Hoje',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.texto,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildEventoCard(
                      hora: '08:00',
                      titulo: 'Reunião com equipe',
                      cor: AppColors.primario,
                    ),
                    _buildEventoCard(
                      hora: '13:30',
                      titulo: 'Aula de Matemática',
                      cor: AppColors.secundario,
                    ),
                    _buildEventoCard(
                      hora: '19:00',
                      titulo: 'Treino de Karatê',
                      cor: AppColors.destaque,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Adicionar Evento'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primario,
                  foregroundColor: Colors.white,
                  textStyle: GoogleFonts.poppins(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventoCard({
    required String hora,
    required String titulo,
    required Color cor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: cor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: cor.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.access_time, color: AppColors.texto),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$hora - $titulo',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.texto,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
