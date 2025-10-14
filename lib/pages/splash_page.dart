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
    bool status = await SharedPrefs().getUserStatus();
    await Future.delayed(Duration(seconds: 3));
    if (status) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomePage(email: '', senha: '',);
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF183D31),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset('assets/images/equilibre.jpg'),
          Spacer(),
          CircularProgressIndicator(
            backgroundColor: Color(0xFF183D31)
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}