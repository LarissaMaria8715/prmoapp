import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final nomeController = TextEditingController(text: "Nome Completo da Silva");
  final dataNascimentoController = TextEditingController(text: "01/01/1111");
  final generoController = TextEditingController(text: "Prefiro não informar");
  final alturaController = TextEditingController(text: "300cm");
  final pesoController = TextEditingController(text: "1000kg");
  final telefoneController = TextEditingController(text: "(99) 99999-9999");
  final emailController = TextEditingController(text: "email@example.com");
  final senhaController = TextEditingController(text: "senha");

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    nomeController.dispose();
    dataNascimentoController.dispose();
    generoController.dispose();
    alturaController.dispose();
    pesoController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          _buildProfilePhoto(),
          const SizedBox(height: 32),

          _buildSectionTitle("INFORMAÇÕES PESSOAIS"),
          const SizedBox(height: 16),
          _buildEditableField(label: "Nome", controller: nomeController),
          _buildEditableField(label: "Data de nascimento", controller: dataNascimentoController),
          _buildEditableField(label: "Gênero", controller: generoController),
          _buildEditableField(label: "Altura (cm)", controller: alturaController),
          _buildEditableField(label: "Peso (kg)", controller: pesoController),
          _buildEditableField(label: "Telefone", controller: telefoneController),

          const SizedBox(height: 32),

          _buildSectionTitle("INFORMAÇÕES DA CONTA"),
          const SizedBox(height: 16),
          _buildEditableField(label: "Email", controller: emailController),
          _buildEditableField(
            label: "Senha",
            controller: senhaController,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.darkTerracotta3,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton.icon(
            icon: const Icon(Icons.save_outlined, color: AppColors.white, size: 25),
            label: Text(
              'Salvar Alterações',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkTerracotta2,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Salvar alterações?'),
                  content: Text('Atenção! As alterações feitas não podem ser desfeitas!'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
                    TextButton(onPressed: () {}, child: Text('Salvar')),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
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
              color: AppColors.darkTerracotta3,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: GoogleFonts.lato(fontSize: 16, color: AppColors.black),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              filled: true,
              fillColor: AppColors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.darkTerracotta3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.darkTerracotta1, width: 2),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.darkTerracotta3,
            backgroundImage: null,
            child: Icon(Icons.person, size: 100, color: AppColors.lightTerracotta1),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              backgroundColor: AppColors.lightTerracotta1,
              radius: 35,
              child: Icon(Icons.edit, size: 34, color: AppColors.darkTerracotta3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.lightTerracotta1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.darkGray4,
            shadows: [
              const Shadow(
                blurRadius: 2,
                color: Colors.black12,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
