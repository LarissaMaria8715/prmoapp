import 'package:flutter/material.dart';
import '../../api/places/restaurante/restaurante_api.dart';
import '../../model/places/restaurante.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class RestaurantesPage extends StatefulWidget {
  const RestaurantesPage({super.key});

  @override
  State<RestaurantesPage> createState() => _RestaurantesPageState();
}

class _RestaurantesPageState extends State<RestaurantesPage> {
  final api = RestaurantsApi();
  late Future<List<Restaurant>> futureRestaurants;

  @override
  void initState() {
    super.initState();
    futureRestaurants = api.findAll();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<Restaurant>>(
        future: futureRestaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar restaurantes.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final restaurantes = snapshot.data ?? [];

          if (restaurantes.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum restaurante encontrado.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: restaurantes.length,
            itemBuilder: (context, index) {
              final item = restaurantes[index];
              return LugarCard(
                titulo: item.nome,
                telefone: item.telefone,
                endereco: item.endereco,
                imagem: 'assets/images/equilibre.jpg',
                corPrimaria: AppColors.darkCoral4,
                corSecundaria: AppColors.darkCoral1,
              );
            },
          );
        },
      ),
    );
  }
}
