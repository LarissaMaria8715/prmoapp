import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';


// Verde   RESPIRAÇÃO-PAGE




class RespiracaoPage extends StatefulWidget {
  const RespiracaoPage({super.key});

  @override
  State<RespiracaoPage> createState() => _RespiracaoPageState();
}

class _RespiracaoPageState extends State<RespiracaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text(
          'Respiração Consciente',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkGreen3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context); // Agora com ação de voltar
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Inspire", // Texto fixo agora
              style: GoogleFonts.lato(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen3,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Container(
                  width: 220, // Tamanho fixo
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.darkGreen3.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Text(
              "Tempo restante: 60 s", // Valor fixo
              style: GoogleFonts.lato(
                fontSize: 18,
                color: AppColors.darkGreen3.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Sem ação (ou coloque uma ação futura)
              },
              icon: const Icon(Icons.replay, color: Colors.white),
              label: Text(
                "Reiniciar",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen3,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
