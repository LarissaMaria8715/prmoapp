import 'package:flutter/material.dart';
import '../../api/places/parks/parks_api.dart';
import '../../model/places/lugar/lugar.dart';
import '../../model/places/parks/park.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class ParquesPage extends StatefulWidget {
  const ParquesPage({super.key});

  @override
  State<ParquesPage> createState() => _ParquesPageState();
}

class _ParquesPageState extends State<ParquesPage> {
  late Future<List<Park>> futureParques;

  @override
  void initState() {
    super.initState();
    futureParques = ParksApi().findAll();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<Park>>(
        future: futureParques,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final parques = snapshot.data!;

          if (parques.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum parque encontrado.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: parques.length,
            itemBuilder: (context, index) {
              final park = parques[index];

              // Cria o objeto Lugar com imagem
              final lugar = Lugar(
                titulo: park.nome,
                telefone: '(00) 00000-0000', // caso não tenha telefone
                endereco: park.endereco,
                imagem: park.imagem, // pega a imagem do parque
                corPrimaria: AppColors.darkLeaf3,
                corSecundaria: AppColors.darkLeaf1,
              );

              return LugarCard(lugar: lugar);
            },
          );
        },
      ),
    );
  }
}
