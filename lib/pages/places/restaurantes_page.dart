import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class RestaurantesPage extends StatelessWidget {
  const RestaurantesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantes = [
      {
        'titulo': 'Sabor da Terra',
        'telefone': '(73) 3333-4444',
        'endereco': 'Av. Cacau, 120 - Centro',
        'imagem': 'assets/images/equilibre.jpg',
      },
      {
        'titulo': 'Bistrô Equilíbrio',
        'telefone': '(73) 98888-5555',
        'endereco': 'Rua Mar Azul, 50 - Pontal',
        'imagem': 'assets/images/equilibre.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightCoral1,
      appBar: AppBar(
        title: const Text(
          'Restaurantes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.darkCoral4,
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: restaurantes.length,
        itemBuilder: (context, index) {
          final item = restaurantes[index];
          return LugarCard(
            titulo: item['titulo']!,
            telefone: item['telefone']!,
            endereco: item['endereco']!,
            imagem: item['imagem']!,
            corPrimaria: AppColors.darkCoral4,
            corSecundaria: AppColors.darkCoral1,
          );
        },
      ),
    );
  }
}