import 'package:equilibreapp/pages/home_page.dart';
import 'package:equilibreapp/pages/register_page.dart';
import 'package:equilibreapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../database/database.dart';


// Cinza LOGIN-PAGE e REGISTER-PAGE




class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DataBase db = DataBase();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGray1,
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bem-vindo ao Equilibre',
                style: GoogleFonts.rubik(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkPurple5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: AppColors.darkPurple3),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightGray4),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: AppColors.darkPurple3),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightGray4),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Lógica de esqueci minha senha
                  },
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                        color: AppColors.darkPurple1
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkPurple5,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _handleLogin,
                icon: Icon(Icons.login, color: AppColors.white),
                label: Text(
                  'Entrar',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.darkPurple5),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Criar uma conta',
                  style: TextStyle(color: AppColors.darkPurple3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    String email = emailController.text.trim();
    String password = passwordController.text;

    bool isValid = db.validateUser(email, password);

    if (isValid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail e/ou senha incorretos!')),
      );
    }
  }

}
