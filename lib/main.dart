import 'package:flutter/material.dart';
import 'pages/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equilibre',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashPage(),
    );
  }
}
