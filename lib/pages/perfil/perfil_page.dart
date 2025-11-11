import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final nomeController = TextEditingController(text: "Nome Completo da Silva");
  final dataNascimentoController = TextEditingController(text: "01/01/1111");
  final generoController = TextEditingController(text: "Prefiro não informar");
  final alturaController = TextEditingController(text: "170 cm");
  final pesoController = TextEditingController(text: "70 kg");
  final telefoneController = TextEditingController(text: "(99) 99999-9999");
  final emailController = TextEditingController(text: "email@example.com");
  final senhaController = TextEditingController(text: "senha");

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.darkGreen5,
        title: Text(
          "Meu Perfil",
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 32),

            _buildSectionCard(
              title: "Informações Pessoais",
              children: [
                _buildEditableField("Nome", nomeController),
                _buildEditableField("Data de nascimento", dataNascimentoController),
                _buildEditableField("Gênero", generoController),
                _buildEditableField("Altura (cm)", alturaController),
                _buildEditableField("Peso (kg)", pesoController),
                _buildEditableField("Telefone", telefoneController),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionCard(
              title: "Informações da Conta",
              children: [
                _buildEditableField("Email", emailController),
                _buildEditableField(
                  "Senha",
                  senhaController,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.darkGreen5,
                    ),
                    onPressed: () {
                      setState(() => _isPasswordVisible = !_isPasswordVisible);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            _buildSaveButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- FOTO DE PERFIL ---
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: AppColors.darkGreen5.withOpacity(0.9),
              child: const Icon(Icons.person, size: 90, color: Colors.white),
            ),
            Positioned(
              bottom: 4,
              right: 6,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.edit, color: AppColors.darkGreen5, size: 24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Nome Completo da Silva",
          style: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen5,
          ),
        ),
        Text(
          "email@example.com",
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // --- SEÇÃO COM CARTÕES ---
  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen5,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  // --- CAMPOS DE TEXTO ---
  Widget _buildEditableField(
      String label,
      TextEditingController controller, {
        bool obscureText = false,
        Widget? suffixIcon,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.lato(fontSize: 16, color: AppColors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.lato(color: Colors.grey[600]),
          filled: true,
          fillColor: const Color(0xFFF4F6F8),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkGreen5, width: 2),
          ),
        ),
      ),
    );
  }

  // --- BOTÃO SALVAR ---
  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save, color: Colors.white),
      label: Text(
        "Salvar Alterações",
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGreen5,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 4,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              "Salvar alterações?",
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "As alterações feitas serão aplicadas permanentemente.",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Salvar"),
              ),
            ],
          ),
        );
      },
    );
  }
}
