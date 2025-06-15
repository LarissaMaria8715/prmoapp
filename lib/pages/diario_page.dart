import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class DiarioPage extends StatefulWidget {
  const DiarioPage({super.key});

  @override
  State<DiarioPage> createState() => _DiarioPageState();
}

class _DiarioPageState extends State<DiarioPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // Importante para evitar memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: AppColors.darkRed3,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
            },
          ),
          title: Text(
            'Diário Pessoal',
            style: GoogleFonts.lato(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Como foi seu dia?",
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkRed3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.darkRed3.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkRed3.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(2, 4),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: AppColors.darkRed3,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Escreva aqui sobre seu dia...',
                            hintStyle: GoogleFonts.lato(
                              color: AppColors.darkRed3.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.save, color: AppColors.white),
                  label: Text(
                    'Salvar Entrada',
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkRed3,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}