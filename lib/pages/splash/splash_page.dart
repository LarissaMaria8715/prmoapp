import 'package:flutter/material.dart';
import '../../utils/shared_prefs.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';

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
    bool status = await SharedPrefs().getUserStatus();

    await Future.delayed(const Duration(seconds: 3));

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
      backgroundColor: Color(0xFF153E2E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image(
            image: AssetImage('assets/images/equilibre.jpg'),
          ),
          Spacer(),
          CircularProgressIndicator(
            backgroundColor: Color(0xFF153E2E),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
