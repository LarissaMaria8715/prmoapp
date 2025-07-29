import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'package:intl/intl.dart';

class HumorPage extends StatefulWidget {
  const HumorPage({super.key});

  @override
  State<HumorPage> createState() => _HumorPageState();
}

class _HumorPageState extends State<HumorPage> {
  String? _selectedHumorEmoji;
  String? _selectedHumorLabel;
  String _name = '';
  DateTime? _selectedDate;

  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSelectHumor(String emoji, String label) {
    setState(() {
      _selectedHumorEmoji = emoji;
      _selectedHumorLabel = label;
      _selectedDate = DateTime.now();
    });
  }

  void _onConfirm() {
    if (_name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite seu nome')),
      );
      return;
    }
    if (_selectedHumorLabel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione seu humor')),
      );
      return;
    }

    final formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Nome: $_name\nHumor: $_selectedHumorLabel $_selectedHumorEmoji\nData: $formattedDate',
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 4),
      ),
    );

    // Aqui você pode salvar no banco de dados, enviar para servidor, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue1,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Digite seu nome",
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlueLight4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              onChanged: (val) => setState(() {
                _name = val;
              }),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Seu nome',
              ),
            ),
            const SizedBox(height: 24),

            Text(
              "Escolha seu humor",
              style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlueLight4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildHumorOption("😄", "Muito feliz"),
                    _buildHumorOption("🙂", "Feliz"),
                    _buildHumorOption("😐", "Neutro"),
                    _buildHumorOption("🙁", "Triste"),
                    _buildHumorOption("😢", "Muito triste"),
                    _buildHumorOption("😠", "Irritado"),
                    _buildHumorOption("😤", "Frustrado"),
                    _buildHumorOption("😨", "Ansioso"),
                    _buildHumorOption("😕", "Confuso"),
                    _buildHumorOption("😬", "Nervoso"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (_selectedDate != null)
              Text(
                'Data da seleção: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBlueLight4,
                ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _onConfirm,
              icon: const Icon(
                Icons.check,
                size: 34,
                color: AppColors.white,
              ),
              label: Text(
                "Confirmar",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlueLight4,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHumorOption(String emoji, String label) {
    final isSelected = _selectedHumorLabel == label;

    return ElevatedButton(
      onPressed: () => _onSelectHumor(emoji, label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? AppColors.darkBlueLight4
            : AppColors.darkBlueLight4.withOpacity(0.15),
        foregroundColor: isSelected
            ? Colors.white
            : AppColors.darkBlueLight4,
        elevation: 0,
        minimumSize: const Size(120, 100),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected
                ? Colors.white
                : AppColors.darkBlueLight4,
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.darkBlueLight4,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      backgroundColor: AppColors.darkBlueLight4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Como você está se sentindo?',
        style: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}