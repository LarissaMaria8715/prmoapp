import 'package:flutter/material.dart';
import '../database/music_dao.dart';
import '../model/music_model.dart';
import '../utils/colors.dart';
import '../wigets/music_card.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final dao = MusicDao();
  List<Music> musicList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadMusic();
  }

  Future<void> loadMusic() async {
    setState(() => loading = true);
    try {
      final list = await dao.findAll();
      setState(() => musicList = list);
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as Músicas '),
        backgroundColor: AppColors.darkGray2,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) => MusicCard(music: musicList[index]),
      ),
    );
  }
}
