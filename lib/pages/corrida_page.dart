import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CorridaPage extends StatefulWidget {
  const CorridaPage({super.key});

  @override
  State<CorridaPage> createState() => _CorridaPageState();
}

class _CorridaPageState extends State<CorridaPage> {
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _tempoController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Registrar Corrida",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputCard(
              label: "Distância (km)",
              controller: _distanciaController,
              icon: Icons.directions_run,
            ),
            const SizedBox(height: 15),
            _buildInputCard(
              label: "Tempo (minutos)",
              controller: _tempoController,
              icon: Icons.timer,
            ),
            const SizedBox(height: 15),
            _buildInputCard(
              label: "Calorias queimadas",
              controller: _caloriasController,
              icon: Icons.local_fire_department,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "Salvar Corrida",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.blueAccent),
            labelText: label,
            labelStyle: GoogleFonts.poppins(fontSize: 15),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
