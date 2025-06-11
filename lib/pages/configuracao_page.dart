import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            // Navegação futura
          },
        ),
        title: Text(
          'Configurações',
          style: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.accent,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          _buildSectionTitle("Conta"),
          const SizedBox(height: 12),
          _buildSubSectionTitle("Perfil"),
          _buildTextField(label: "Nome", hint: "Seu nome completo"),
          _buildTextField(label: "Email", hint: "seu@email.com"),
          _buildProfilePhotoSelector(),
          const SizedBox(height: 24),
          _buildSubSectionTitle("Segurança"),
          _buildPasswordField(label: "Senha atual"),
          _buildPasswordField(label: "Nova senha"),
          _buildPasswordField(label: "Confirmar nova senha"),
          _buildButton(
            label: "Alterar senha",
            onPressed: () {},
          ),
          const SizedBox(height: 24),
          _buildButton(
            label: "Sair da conta",
            color: Colors.red.shade600,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          _buildButton(
            label: "Excluir conta",
            color: Colors.red.shade900,
            onPressed: () {},
          ),
          const SizedBox(height: 28),
          _buildSectionTitle("Aplicativo"),
          const SizedBox(height: 12),
          _buildSubSectionTitle("Notificações"),
          _buildSwitchSetting(
            title: "Ativar notificações",
            value: true,
            onChanged: (val) {},
          ),
          _buildSwitchSetting(
            title: "Notificações por e-mail",
            value: false,
            onChanged: (val) {},
          ),
          _buildSwitchSetting(
            title: "Notificações sonoras",
            value: true,
            onChanged: (val) {},
          ),
          const SizedBox(height: 24),
          _buildSubSectionTitle("Idioma"),
          _buildDropdownSetting(
            label: "Idioma do app",
            options: ["Português (Brasil)", "English (US)", "Español"],
            selectedOption: "Português (Brasil)",
            onChanged: (val) {},
          ),

          const SizedBox(height: 24),
          _buildSubSectionTitle("Privacidade"),
          _buildSwitchSetting(
            title: "Compartilhar dados anonimamente",
            value: true,
            onChanged: (val) {},
          ),
          _buildSwitchSetting(
            title: "Permitir localização",
            value: false,
            onChanged: (val) {},
          ),
          const SizedBox(height: 24),
          _buildSubSectionTitle("Suporte"),
          _buildSettingItem(
            icon: Icons.support_agent,
            title: 'Ajuda e suporte',
            description:
            'Encontre respostas para dúvidas frequentes ou entre em contato com nossa equipe.',
            onTap: () {

            },
          ),
          _divider(),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'Sobre o app',
            description:
            'Versão 1.0.0 — Informações gerais sobre o aplicativo e seus desenvolvedores.',
            onTap: () {

            },
          ),
        ],
      ),
    );
  }

  _buildTextField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        enabled: false, // Só visual por enquanto
      ),
    );
  }

  _buildPasswordField({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        enabled: false, // só layout
      ),
    );
  }

  _buildProfilePhotoSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, size: 40, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "Alterar foto de perfil",
              style: GoogleFonts.lato(
                fontSize: 16,
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.accent),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  _buildButton({
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.accent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  _buildSwitchSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      activeColor: AppColors.accent,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.lato(fontSize: 16)),
      value: value,
      onChanged: (_) {},
    );
  }

  _buildDropdownSetting({
    required String label,
    required List<String> options,
    required String selectedOption,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedOption,
            isExpanded: true,
            items: options
                .map((opt) => DropdownMenuItem(
              value: opt,
              child: Text(opt),
            ))
                .toList(),
            onChanged: (val) {},
          ),
        ),
      ),
    );
  }

  _buildSettingItem({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      leading: Icon(icon, color: AppColors.accent, size: 32),
      title: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          description,
          style: GoogleFonts.lato(fontSize: 14, color: Colors.black87),
        ),
      ),
      onTap: onTap,
    );
  }

   _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }

  _buildSubSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      ),
    );
  }

  _divider() {
    return const Divider(height: 1, thickness: 1);
  }
}
