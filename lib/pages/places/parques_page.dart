import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class ParquesPage extends StatelessWidget {
  const ParquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parques = [
      {
        'titulo': 'Parque das Águas',
        'telefone': '(73) 99911-2233',
        'endereco': 'Av. Central, 200 - Bairro Jardim',
        'imagem': 'assets/images/equilibre.jpg',
      },
      {
        'titulo': 'Bosque Verde Vida',
        'telefone': '(73) 98877-5566',
        'endereco': 'Rua das Árvores, 45 - Centro',
        'imagem': 'assets/images/equilibre.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightLeaf1,
      appBar: AppBar(
        title: const Text(
          'Parques',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.darkLeaf4,
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: parques.length,
        itemBuilder: (context, index) {
          final item = parques[index];
          return LugarCard(
            titulo: item['titulo']!,
            telefone: item['telefone']!,
            endereco: item['endereco']!,
            imagem: item['imagem']!,
            corPrimaria: AppColors.darkLeaf3,
            corSecundaria: AppColors.darkLeaf1,
            onVerMapa: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Abrindo ${item['titulo']} no mapa...'),
                  backgroundColor: AppColors.leaf,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
