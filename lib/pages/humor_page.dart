import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import '../database/humor_dao.dart';
import '../model/humor_model.dart';
import '../api/humor_api.dart';

class HumorPage extends StatefulWidget {
  const HumorPage({super.key});

  @override
  State<HumorPage> createState() => _HumorPageState();
}

class _HumorPageState extends State<HumorPage> {
  String? _selectedHumorEmoji;
  String? _selectedHumorLabel;
  final HumorDAO _dao = HumorDAO();
  final int usuarioId = 1;
  List<Humor> _humores = [];
  final HumorApi _api = HumorApi();


  Future<void> _loadHumoresFromApi() async {
    try {
      final list = await _api.findAll();
      setState(() => _humores = list);
    } catch (e) {
      _showSnack("Erro ao carregar humores da API: $e");
    }
  }

  final List<Map<String, String>> _opcoesHumor = [
    {"emoji": "😄", "label": "Muito feliz"},
    {"emoji": "🙂", "label": "Feliz"},
    {"emoji": "😐", "label": "Neutro"},
    {"emoji": "🙁", "label": "Triste"},
    {"emoji": "😢", "label": "Muito triste"},
    {"emoji": "😠", "label": "Irritado"},
    {"emoji": "😤", "label": "Frustrado"},
    {"emoji": "😨", "label": "Ansioso"},
    {"emoji": "😕", "label": "Confuso"},
    {"emoji": "😬", "label": "Nervoso"},
  ];

  @override
  void initState() {
    super.initState();
    _loadHumoresFromApi();
  }

  Future<void> _loadHumores() async {
    final list = await _dao.listarPorUsuario(usuarioId);
    setState(() => _humores = list);
  }

  void _onSelectHumor(String emoji, String label) {
    setState(() {
      _selectedHumorEmoji = emoji;
      _selectedHumorLabel = label;
    });
  }

  Future<void> _onConfirm() async {
    if (_selectedHumorLabel == null) {
      _showSnack("Por favor, selecione seu humor antes de confirmar!");
      return;
    }

    final data = DateTime.now();
    final String DataFormat = DateFormat('dd/MM/yyyy – HH:mm').format(data);

    Humor novoHumor = Humor(
      usuarioId: usuarioId,
      humorLabel: _selectedHumorLabel!,
      humorEmoji: _selectedHumorEmoji!,
      data: DataFormat,
    );

    await _dao.salvar(novoHumor);

    _showSnack("Humor salvo! ${novoHumor.humorLabel} ${novoHumor.humorEmoji} - ${novoHumor.data}");

    setState(() {
      _selectedHumorEmoji = null;
      _selectedHumorLabel = null;
    });

    _loadHumores();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: const TextStyle(fontSize: 16))),
    );
  }

  Future<void> _confirmDelete(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: const Text("Deseja realmente excluir este registro de humor?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _dao.deletar(id);
      _loadHumores();
      _showSnack("Humor excluído com sucesso");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue1,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle("Como você está se sentindo hoje?"),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: _opcoesHumor
                  .map((op) => _buildHumorOption(op["emoji"]!, op["label"]!))
                  .toList(),
            ),
            const SizedBox(height: 16),
            _buildConfirmButton(),
            const SizedBox(height: 24),
            _buildTitle("Histórico de humores", size: 20),
            const SizedBox(height: 12),
            Expanded(
              child: _humores.isEmpty
                  ? _buildEmptyMessage()
                  : _buildHumoresList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text, {double size = 28}) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlueDark4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        "Nenhum humor registrado ainda.",
        style: GoogleFonts.lato(fontSize: 16, color: AppColors.lightBlueDark4),
      ),
    );
  }

  Widget _buildHumoresList() {
    return ListView.builder(
      itemCount: _humores.length,
      itemBuilder: (context, index) {
        final humor = _humores[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          color: Colors.white,
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            leading: Text(humor.humorEmoji, style: const TextStyle(fontSize: 34)),
            title: Text(
              humor.humorLabel,
              style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.lightBlueDark4,),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(humor.data, style: GoogleFonts.lato(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(humor.id!),
            ),
          ),
        );
      },
    );
  }


  Widget _buildHumorOption(String emoji, String label) {
    final isSelected = _selectedHumorLabel == label;
    return ElevatedButton(
      onPressed: () => _onSelectHumor(emoji, label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.lightBlueDark4 : AppColors.darkBlueDark4,
        foregroundColor: isSelected ? Colors.white : AppColors.lightBlueDark4,
        elevation: 2,
        minimumSize: const Size(80, 80),
        padding: const EdgeInsets.all(6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: isSelected ? Colors.white : AppColors.lightBlueDark4, width: 1.5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.lightBlueDark4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton.icon(
      onPressed: _onConfirm,
      icon: const Icon(Icons.check_circle, size: 28, color: AppColors.white),
      label: Text(
        "Confirmar Humor",
        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlueDark4,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: AppColors.lightBlueDark4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Registro de Humor',
        style: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
