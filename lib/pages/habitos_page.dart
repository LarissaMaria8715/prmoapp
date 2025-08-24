import 'dart:convert';
import 'package:flutter/material.dart';
import '../database/habito_dao.dart';
import '../model/habito_model.dart';
import '../utils/colors.dart';

class HabitosPage extends StatefulWidget {
  const HabitosPage({Key? key}) : super(key: key);

  @override
  _HabitosPageState createState() => _HabitosPageState();
}

class _HabitosPageState extends State<HabitosPage> {
  // Sliders
  double aguaLitros = 0.0;
  double horasSono = 0.0;
  double nivelEstresse = 0.0;
  double tempoTela = 0.0;
  double tempoAoArLivre = 0.0;
  double nivelMotivacao = 5.0;

  // Checkboxes
  bool meditou = false;
  bool fezExercicio = false;
  bool alimentacaoSaudavel = false;
  bool comeuFrutas = false;
  bool leuLivro = false;
  bool teveContatoSocial = false;
  bool praticouGratidao = false;

  // Autoavaliação e observação
  int autoAvaliacao = 3;
  final observacaoController = TextEditingController();

  final habitoDAO = HabitoDAO();
  final int usuarioId = 1;

  // Widgets auxiliares
  Widget _tituloSecao(String texto) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Text(
      texto,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.purple),
    ),
  );

  Widget _card({required Widget child}) => Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey, width: 1.2),
    ),
    child: child,
  );

  Widget _sliderHabit({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String unidade,
    required Function(double) onChanged,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: '${value.toStringAsFixed(1)} $unidade',
            activeColor: AppColors.purple,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _checkboxHabit(String texto, bool valor, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(texto, style: const TextStyle(fontSize: 16)),
      value: valor,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.purple,
    );
  }

  // Salvar hábitos usando o model Habito
  Future<void> _salvarHabitos() async {
    try {
      final now = DateTime.now();

      final habito = Habito(
        usuarioId: usuarioId,
        nome: 'Registro diário',
        descricao: jsonEncode({
          'aguaLitros': aguaLitros,
          'horasSono': horasSono,
          'nivelEstresse': nivelEstresse,
          'tempoTela': tempoTela,
          'tempoAoArLivre': tempoAoArLivre,
          'nivelMotivacao': nivelMotivacao,
          'meditou': meditou,
          'fezExercicio': fezExercicio,
          'alimentacaoSaudavel': alimentacaoSaudavel,
          'comeuFrutas': comeuFrutas,
          'leuLivro': leuLivro,
          'teveContatoSocial': teveContatoSocial,
          'praticouGratidao': praticouGratidao,
          'autoAvaliacao': autoAvaliacao,
        }),
        data: now.toIso8601String(),
      );

      await habitoDAO.salvarHabito(habito);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hábitos salvos com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Erro ao salvar hábito: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar hábitos.')),
      );
    }
  }
  @override
  void dispose() {
    observacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        toolbarHeight: 80,
        title: const Text(
          'Meus Hábitos Diários',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            _tituloSecao('Hábitos Quantitativos'),
            _sliderHabit(
              title: 'Consumo de Água',
              value: aguaLitros,
              min: 0,
              max: 5,
              divisions: 15,
              unidade: 'L',
              onChanged: (v) => setState(() => aguaLitros = v),
            ),
            _sliderHabit(
              title: 'Horas de Sono',
              value: horasSono,
              min: 0,
              max: 15,
              divisions: 15,
              unidade: 'h',
              onChanged: (v) => setState(() => horasSono = v),
            ),
            _sliderHabit(
              title: 'Estresse (0 a 10)',
              value: nivelEstresse,
              min: 0,
              max: 10,
              divisions: 10,
              unidade: '',
              onChanged: (v) => setState(() => nivelEstresse = v),
            ),
            _sliderHabit(
              title: 'Motivação (0 a 10)',
              value: nivelMotivacao,
              min: 0,
              max: 10,
              divisions: 10,
              unidade: '',
              onChanged: (v) => setState(() => nivelMotivacao = v),
            ),
            _sliderHabit(
              title: 'Tempo de Tela',
              value: tempoTela,
              min: 0,
              max: 20,
              divisions: 20,
              unidade: 'h',
              onChanged: (v) => setState(() => tempoTela = v),
            ),
            _sliderHabit(
              title: 'Tempo ao Ar Livre',
              value: tempoAoArLivre,
              min: 0,
              max: 20,
              divisions: 20,
              unidade: 'h',
              onChanged: (v) => setState(() => tempoAoArLivre = v),
            ),

            _tituloSecao('Hábitos Binários'),
            _card(
              child: Column(
                children: [
                  _checkboxHabit('Meditou hoje?', meditou, (v) => setState(() => meditou = v ?? false)),
                  _checkboxHabit('Fez exercícios físicos?', fezExercicio, (v) => setState(() => fezExercicio = v ?? false)),
                  _checkboxHabit('Alimentação saudável?', alimentacaoSaudavel, (v) => setState(() => alimentacaoSaudavel = v ?? false)),
                  _checkboxHabit('Comeu frutas?', comeuFrutas, (v) => setState(() => comeuFrutas = v ?? false)),
                  _checkboxHabit('Leu algum livro?', leuLivro, (v) => setState(() => leuLivro = v ?? false)),
                  _checkboxHabit('Teve contato social?', teveContatoSocial, (v) => setState(() => teveContatoSocial = v ?? false)),
                ],
              ),
            ),

            _tituloSecao('Autoavaliação do Dia'),
            _card(
              child: DropdownButtonFormField<int>(
                value: autoAvaliacao,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: List.generate(5, (i) {
                  final label = ['Péssimo', 'Ruim', 'Regular', 'Bom', 'Excelente'][i];
                  return DropdownMenuItem(value: i + 1, child: Text('${i + 1} - $label'));
                }),
                onChanged: (v) => setState(() => autoAvaliacao = v!),
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save_alt, color: AppColors.lightPurple1),
                label: const Text(
                  'Salvar Hábito',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightPurple1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Salvar hábitos'),
                    content: const Text('Deseja salvar os hábitos de hoje?'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _salvarHabitos();
                        },
                        child: const Text('Salvar', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
