// Arquivo: register_page.dart

import 'package:flutter/material.dart';
import 'package:equilibreapp/utils/colors.dart';
import '../database/user_dao.dart';
import '../model/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final UserDAO userDAO = UserDAO();

  // Controladores
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final sleepHoursController = TextEditingController();
  final healthConditionController = TextEditingController();

  // Estados
  String? selectedGender;
  String? selectedGoal;
  bool meditate = false;
  bool receiveNotifications = true;
  bool _acceptedTerms = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen1,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.darkBlueDark4,
        foregroundColor: AppColors.white,
        title: const Text('Criar Conta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Preencha seu perfil completo para personalizar sua experiência',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkBlueDark5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              _buildTextField(nameController, 'Nome', Icons.person),
              _buildTextField(emailController, 'E-mail', Icons.email, keyboardType: TextInputType.emailAddress),
              _buildTextField(passwordController, 'Senha', Icons.lock, obscureText: !_showPassword, suffixIcon: _passwordToggle(true)),
              _buildTextField(confirmPasswordController, 'Confirmar Senha', Icons.lock_outline, obscureText: !_showConfirmPassword, suffixIcon: _passwordToggle(false)),
              _buildTextField(birthDateController, 'Data de Nascimento (dd/mm/aaaa)', Icons.calendar_today),
              _buildDropdownField('Gênero', ['Feminino', 'Masculino', 'Outro', 'Prefiro não dizer'], (value) => selectedGender = value, selectedGender),
              _buildTextField(heightController, 'Altura (cm)', Icons.height, keyboardType: TextInputType.number),
              _buildTextField(weightController, 'Peso (kg)', Icons.monitor_weight, keyboardType: TextInputType.number),
              _buildTextField(sleepHoursController, 'Horas de sono por noite', Icons.nightlight, keyboardType: TextInputType.number),
              _buildDropdownField('Objetivo Principal', ['Relaxar', 'Dormir melhor', 'Melhorar hábitos', 'Outro'], (value) => selectedGoal = value, selectedGoal),
              _buildTextField(healthConditionController, 'Condições de saúde (opcional)', Icons.health_and_safety),

              SwitchListTile(
                value: meditate,
                onChanged: (v) => setState(() => meditate = v),
                title: const Text('Você pratica meditação?'),
              ),
              SwitchListTile(
                value: receiveNotifications,
                onChanged: (v) => setState(() => receiveNotifications = v),
                title: const Text('Deseja receber notificações diárias?'),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                  ),
                  const Expanded(
                    child: Text('Li e aceito os termos de uso e política de privacidade'),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlueDark5,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                icon: const Icon(Icons.check, color: AppColors.white),
                label: const Text('Cadastrar', style: TextStyle(color: AppColors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) => (label.contains('Senha') && value != null && value.length < 6)
            ? 'Mínimo 6 caracteres'
            : (label == 'Confirmar Senha' && value != passwordController.text)
            ? 'Senhas não coincidem'
            : (label != 'Condições de saúde (opcional)' && (value == null || value.isEmpty))
            ? 'Campo obrigatório'
            : null,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, Function(String?) onChanged, String? selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onChanged: (value) => setState(() => onChanged(value)),
        items: options
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        validator: (value) => value == null ? 'Selecione uma opção' : null,
      ),
    );
  }

  IconButton _passwordToggle(bool isMainPassword) {
    return IconButton(
      icon: Icon(
        isMainPassword ? (_showPassword ? Icons.visibility_off : Icons.visibility)
            : (_showConfirmPassword ? Icons.visibility_off : Icons.visibility),
        color: AppColors.darkBlueDark5,
      ),
      onPressed: () => setState(() => isMainPassword ? _showPassword = !_showPassword : _showConfirmPassword = !_showConfirmPassword),
    );
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aceite os termos para continuar.'), backgroundColor: Colors.red),
      );
      return;
    }

    final user = UserModel(
      nome: nameController.text.trim(),
      email: emailController.text.trim(),
      senha: passwordController.text,
      dataNascimento: birthDateController.text,
      genero: selectedGender ?? '',
      altura: double.tryParse(heightController.text) ?? 0.0,
      peso: double.tryParse(weightController.text) ?? 0.0,
      objetivo: selectedGoal ?? '',
      praticaMeditacao: meditate,
      condicaoSaude: healthConditionController.text.trim().isEmpty ? null : healthConditionController.text.trim(),
      recebeNotificacoes: receiveNotifications,
      telefone: null, // Adicione um campo de telefone no formulário se desejar
      cidade: null,   // Idem
      estado: null,   // Idem
    );


    try {
      await userDAO.insertUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!'), backgroundColor: AppColors.green),
      );
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar. Verifique os dados.'), backgroundColor: Colors.red),
      );
    }
  }
}
