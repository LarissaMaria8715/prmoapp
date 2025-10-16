import 'package:flutter/material.dart';
import '../utils/shared_prefs.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  checkUserLogin() async {
    // Usa apenas o método já existente em SharedPrefs
    bool status = await SharedPrefs().getUserStatus();

    // Espera 3 segundos para exibir a splash
    await Future.delayed(const Duration(seconds: 3));

    // Redireciona conforme o status salvo
    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(
            email: '',
            senha: '',
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF183D31),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image(
            image: AssetImage('assets/images/equilibre.jpg'),
          ),
          Spacer(),
          CircularProgressIndicator(
            backgroundColor: Color(0xFF183D31),
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
