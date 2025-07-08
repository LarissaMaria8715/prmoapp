import 'package:flutter/material.dart';
import 'package:equilibreapp/utils/colors.dart';




// Cinza LOGIN-PAGE e REGISTER-PAGE




class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen1,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Criar Conta'),
        backgroundColor: AppColors.darkBlueDark4,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               SizedBox(height: 70),
              Text(
                'Preencha seus dados para se cadastrar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkBlueDark5,
                ),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 24),

              // Nome
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person, color: AppColors.darkBlueDark5),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe seu nome' : null,
              ),
              const SizedBox(height: 16),

              // E-mail
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email, color: AppColors.darkBlueDark5),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                value != null && value.contains('@') ? null : 'E-mail inválido',
              ),
              const SizedBox(height: 16),

              // Senha
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock, color: AppColors.darkBlueDark5),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value != null && value.length >= 6
                    ? null
                    : 'A senha deve ter no mínimo 6 caracteres',
              ),
              const SizedBox(height: 16),

              // Confirmar Senha
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.darkBlueDark5),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) => value == passwordController.text
                    ? null
                    : 'As senhas não coincidem',
              ),
              const SizedBox(height: 24),

              // Botão Cadastrar
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlueDark5,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.check, color: AppColors.white),
                label: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 16, color: AppColors.white),
                ),
                onPressed: _handleRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Cadastro realizado com sucesso!'),
          backgroundColor: AppColors.Green,
          duration: Duration(seconds: 2), // para o usuário ver a mensagem
        ),
      );

      // Espera o SnackBar aparecer antes de voltar
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context); // Volta para a tela de login
      });
    }
  }
}
