import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugares_button.dart';
import 'hospitais_page.dart';
import 'parques_page.dart';

class LugaresPage extends StatelessWidget {
  const LugaresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: AppBar(
        title: Text(
          'Lugares',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.darkPink2,
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LugaresButton(
                icon: Icons.local_hospital_outlined,
                label: 'Hospitais',
                backgroundColor: AppColors.darkTurquoise4,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HospitaisPage()),
                ),
              ),
              const SizedBox(height: 24),
              LugaresButton(
                icon: Icons.park_outlined,
                label: 'Parques',
                backgroundColor: AppColors.darkLeaf4,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ParquesPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}