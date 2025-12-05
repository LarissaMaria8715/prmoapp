import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/splash/splash_page.dart';
import 'provider/favoritos_provider.dart'; // importe o provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritosProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equilibre',
      home: const SplashPage(),
    );
  }
}
