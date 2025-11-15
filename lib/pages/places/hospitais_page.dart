import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class HospitaisPage extends StatelessWidget {
  const HospitaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hospitais = [
      {
        'titulo': 'Hospital Esperança',
        'telefone': '(73) 99123-4567',
        'endereco': 'Av. Principal, 100 - Cidade Nova',
        'imagem': 'assets/images/equilibre.jpg',
      },
      {
        'titulo': 'Clínica São Lucas',
        'telefone': '(73) 99999-0000',
        'endereco': 'Rua Saúde, 89 - Centro',
        'imagem': 'assets/images/equilibre.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightTurquoise1,
      appBar: AppBar(
        title: const Text(
          'Hospitais',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.darkTurquoise4,
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hospitais.length,
        itemBuilder: (context, index) {
          final item = hospitais[index];
          return LugarCard(
            titulo: item['titulo']!,
            telefone: item['telefone']!,
            endereco: item['endereco']!,
            imagem: item['imagem']!,
            corPrimaria: AppColors.darkTurquoise3,
            corSecundaria: AppColors.darkTurquoise2,
          );
        },
      ),
    );
  }
}
