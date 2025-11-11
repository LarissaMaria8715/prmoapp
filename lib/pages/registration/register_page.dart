import 'package:flutter/material.dart';
import 'package:equilibreapp/utils/colors.dart';
import '../../database/user/user_dao.dart';
import '../../model/user/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final UsuarioDAO userDAO = UsuarioDAO();

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
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

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
        toolbarHeight: 70,
        backgroundColor: AppColors.darkBlueDark4,
        foregroundColor: AppColors.white,
        title: const Text('Criar Conta'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Complete seu perfil para uma experiência personalizada',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkBlueDark5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Campos de texto
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
              _buildTextField(phoneController, 'Telefone (opcional)', Icons.phone, keyboardType: TextInputType.phone),
              _buildTextField(cityController, 'Cidade (opcional)', Icons.location_city),
              _buildTextField(stateController, 'Estado (opcional)', Icons.map),

              const SizedBox(height: 12),

              // Switches
              SwitchListTile(
                value: meditate,
                onChanged: (v) => setState(() => meditate = v),
                title: const Text('Você pratica meditação?'),
                activeColor: AppColors.darkBlueDark5,
                contentPadding: EdgeInsets.zero,
              ),
              SwitchListTile(
                value: receiveNotifications,
                onChanged: (v) => setState(() => receiveNotifications = v),
                title: const Text('Receber notificações diárias?'),
                activeColor: AppColors.darkBlueDark5,
                contentPadding: EdgeInsets.zero,
              ),

              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                    activeColor: AppColors.darkBlueDark5,
                  ),
                  const Expanded(
                    child: Text('Li e aceito os termos de uso e política de privacidade'),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Botão principal
              ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlueDark5,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
                child: const Center(
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.darkBlueDark5),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white.withOpacity(0.95),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.darkBlueDark5, width: 2)),
        ),
        validator: (value) => (label.contains('Senha') && value != null && value.length < 6)
            ? 'Mínimo 6 caracteres'
            : (label == 'Confirmar Senha' && value != passwordController.text)
            ? 'Senhas não coincidem'
            : (label != 'Condições de saúde (opcional)' && label != 'Telefone (opcional)' && label != 'Cidade (opcional)' && label != 'Estado (opcional)' && (value == null || value.isEmpty))
            ? 'Campo obrigatório'
            : null,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, Function(String?) onChanged, String? selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white.withOpacity(0.95),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.darkBlueDark5, width: 2)),
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

    Usuario usuario = Usuario(
      nome: nameController.text.trim(),
      email: emailController.text.trim(),
      senha: passwordController.text,
      dataNascimento: birthDateController.text,
      genero: selectedGender ?? '',
      altura: double.tryParse(heightController.text) ?? 0.0,
      peso: double.tryParse(weightController.text) ?? 0.0,
      objetivo: selectedGoal ?? '',
      praticaMeditacao: meditate ? 1 : 0,
      recebeNotificacoes: receiveNotifications ? 1 : 0,
      condicaoSaude: healthConditionController.text.trim(),
      telefone: phoneController.text.trim(),
      cidade: cityController.text.trim(),
      estado: stateController.text.trim(),
    );

    try {
      await userDAO.salvar(usuario);

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
