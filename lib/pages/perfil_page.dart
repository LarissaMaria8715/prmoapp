import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWine0,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'PERFIL',
          style: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.darkWine5,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          _buildSectionTitle("Informações básicas"),
          const SizedBox(height: 16),
          _buildProfilePhoto(),
          const SizedBox(height: 20),
          _buildDisplayField(label: "Nome", value: "Larissa Maria da Silva"),
          _buildDisplayField(label: "Email", value: "larissa@example.com"),
          _buildDisplayField(label: "Telefone", value: "(99) 99999-9999"),
          _buildDisplayField(label: "Data de nascimento", value: "01/01/1990"),
          _buildDisplayField(label: "Endereço", value: "Rua Exemplo, 123 - Cidade, Estado"),
          const SizedBox(height: 32),

          ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: Text(
              'Editar perfil',
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightWine0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkWine5,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              // Aqui poderia abrir um formulário para editar o perfil
            },
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            icon: const Icon(
                Icons.logout,
                color: AppColors.darkWine5,
            ),
            label: Text(
              'Sair',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkWine5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightWine3,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              // Função para deslogar
            },
          ),
        ],
      ),
    );
  }

  _buildProfilePhoto() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.lightWine1,
            backgroundImage: null, // substitua por uma imagem se desejar
            child: Icon(Icons.person, size: 100, color: AppColors.darkWine4),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              backgroundColor: AppColors.darkWine4,
              radius: 35,
              child: Icon(Icons.edit, size: 34, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  _buildDisplayField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGray2,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.lightGray3),
            ),
            child: Text(
              value,
              style: GoogleFonts.lato(fontSize: 16, color: AppColors.darkGray3),
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.darkGray4,
      ),
    );
  }
}
