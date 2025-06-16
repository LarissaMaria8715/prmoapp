import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';


class AgendaPage extends StatelessWidget {
  const AgendaPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBordeaux1,
        appBar: AppBar(
          toolbarHeight: 90,
          title: Text(
            'Agenda',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),


          centerTitle: true,
          backgroundColor: AppColors.lightBordeaux3,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              Navigator.pop(context); // Agora com ação de voltar
            },
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
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildEventoCard(
                      hora: '08:00',
                      titulo: 'Reunião com equipe',
                      cor: AppColors.darkBordeaux4,
                    ),
                    _buildEventoCard(
                      hora: '13:30',
                      titulo: 'Aula de Matemática',
                      cor: AppColors.Bordeaux,
                    ),
                    _buildEventoCard(
                      hora: '19:00',
                      titulo: 'Treino de Karatê',
                      cor: AppColors.darkBordeaux4,
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
                  backgroundColor: AppColors.Bordeaux,
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
              Icon(Icons.access_time, color: AppColors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$hora - $titulo',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
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

