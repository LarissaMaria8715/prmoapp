import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HumorPage extends StatelessWidget {
  const HumorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundo,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: AppColors.primario,
        title: Text(
          'Como você está se sentindo?',
          style: GoogleFonts.lato(
            color: AppColors.texto,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Escolha seu humor",
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.texto,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 50,
              alignment: WrapAlignment.center,
              children: [
                _buildHumorOption(Icons.sentiment_very_satisfied, "Muito feliz"),
                _buildHumorOption(Icons.sentiment_satisfied, "Feliz"),
                _buildHumorOption(Icons.sentiment_neutral, "Neutro"),
                _buildHumorOption(Icons.sentiment_dissatisfied, "Triste"),
                _buildHumorOption(Icons.sentiment_very_dissatisfied, "Muito triste"),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primario,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "Confirmar",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildHumorOption(IconData icon, String label) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.secundario.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.primario),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              color: AppColors.texto,
            ),
          ),
        ],
      ),
    );
  }
}
