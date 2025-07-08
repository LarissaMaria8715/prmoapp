import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';


class HumorPage extends StatelessWidget {
  const HumorPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue1,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Escolha seu humor",
              style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlueLight4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildHumorOption("😄", "Muito feliz"),
                    _buildHumorOption("🙂", "Feliz"),
                    _buildHumorOption("😐", "Neutro"),
                    _buildHumorOption("🙁", "Triste"),
                    _buildHumorOption("😢", "Muito triste"),
                    _buildHumorOption("😠", "Irritado"),
                    _buildHumorOption("😤", "Frustrado"),
                    _buildHumorOption("😨", "Ansioso"),
                    _buildHumorOption("😕", "Confuso"),
                    _buildHumorOption("😬", "Nervoso"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Ação futura ao confirmar humor
              },
              icon: const Icon(
                  Icons.check,
                  size: 34,
                  color: AppColors.white),
              label: Text(
                "Confirmar",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlueLight4,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _buildHumorOption(String emoji, String label) {
    return ElevatedButton(
      onPressed: () {
        // Ação futura ao selecionar o humor
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlueLight4.withOpacity(0.15),
        foregroundColor: AppColors.darkBlueLight4,
        elevation: 0,
        minimumSize: const Size(120, 100),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.darkBlueLight4, width: 1.5),
        ),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlueLight4,
            ),
          ),
        ],
      ),
    );
  }


  _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      backgroundColor: AppColors.darkBlueLight4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () {
          // Navegação futura
        },
      ),
      title: Text(
        'Como você está se sentindo?',
        style: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}

