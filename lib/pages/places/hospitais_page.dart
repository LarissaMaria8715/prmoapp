import 'package:flutter/material.dart';
import '../../api/places/hospital/hospital_api.dart';
import '../../model/hospital/hospital.dart';
import '../../utils/colors.dart';
import '../../wigets/places/lugar_card.dart';

class HospitaisPage extends StatefulWidget {
  const HospitaisPage({super.key});

  @override
  State<HospitaisPage> createState() => _HospitaisPageState();
}

class _HospitaisPageState extends State<HospitaisPage> {
  final api = HospitalsApi();
  late Future<List<Hospital>> futureHospitais;

  @override
  void initState() {
    super.initState();
    futureHospitais = api.findAll();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<Hospital>>(
        future: futureHospitais,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar hospitais.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final hospitais = snapshot.data ?? [];

          if (hospitais.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum hospital encontrado.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: hospitais.length,
            itemBuilder: (context, index) {
              final item = hospitais[index];
              return LugarCard(
                titulo: item.nome,
                telefone: item.telefone,
                endereco: item.endereco,
                imagem: 'assets/images/equilibre.jpg',
                corPrimaria: AppColors.darkTurquoise3,
                corSecundaria: AppColors.darkTurquoise2,
              );
            },
          );
        },
      ),
    );
  }
}
