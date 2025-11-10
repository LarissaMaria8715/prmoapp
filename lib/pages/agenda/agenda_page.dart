import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBordeaux0,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.lightBordeaux3,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Minha Agenda',
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compromissos de Hoje',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBordeaux4,
                ),
              ),
              const SizedBox(height: 20),

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
                      cor: AppColors.bordeaux,
                    ),
                    _buildEventoCard(
                      hora: '19:00',
                      titulo: 'Treino de Karatê',
                      cor: AppColors.darkBordeaux4,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Ação ao adicionar evento
                  },
                  icon: const Icon(Icons.add, size: 22),
                  label: const Text(
                    'Adicionar Evento',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.bordeaux,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cor.withOpacity(0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: cor.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Icon(Icons.access_time, color: cor),
        title: Text(
          titulo,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          hora,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        trailing: const Icon(Icons.more_vert, color: Colors.white60),
      ),
    );
  }
}
