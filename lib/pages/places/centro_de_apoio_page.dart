import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class CentrosApoioPage extends StatelessWidget {
  const CentrosApoioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final centros = [
      {
        'titulo': 'Centro de Apoio Vida Plena',
        'telefone': '(73) 99456-7890',
        'endereco': 'Rua das Flores, 10 - Primavera',
        'imagem': 'assets/images/equilibre.jpg',
      },
      {
        'titulo': 'Espaço Harmonia',
        'telefone': '(73) 99111-2222',
        'endereco': 'Av. da Paz, 65 - Jardim Europa',
        'imagem': 'assets/images/equilibre.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightLavender1,
      appBar: AppBar(
        title: const Text(
          'Centros de Apoio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.darkLavender4,
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: centros.length,
        itemBuilder: (context, index) {
          final item = centros[index];
          return LugarCard(
            titulo: item['titulo']!,
            telefone: item['telefone']!,
            endereco: item['endereco']!,
            imagem: item['imagem']!,
            corPrimaria: AppColors.darkLavender3,
            corSecundaria: AppColors.darkLavender1,
          );
        },
      ),
    );
  }
}
