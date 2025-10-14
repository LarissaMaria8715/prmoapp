import 'dart:convert';
import 'package:flutter/material.dart';
import '../api/habitos_api.dart';
import '../database/habito_dao.dart';
import '../model/habito_model.dart';
import '../utils/colors.dart';

class HabitosPage extends StatefulWidget {
  const HabitosPage({Key? key}) : super(key: key);

  @override
  _HabitosPageState createState() => _HabitosPageState();
}

class _HabitosPageState extends State<HabitosPage> {
  double aguaLitros = 0.0;
  double horasSono = 0.0;
  double nivelEstresse = 0.0;
  double tempoTela = 0.0;
  double tempoAoArLivre = 0.0;
  double nivelMotivacao = 0.0;

  bool meditou = false;
  bool fezExercicio = false;
  bool alimentacaoSaudavel = false;
  bool comeuFrutas = false;
  bool leuLivro = false;
  bool teveContatoSocial = false;

  int autoAvaliacao = 3;

  final habitosApi = HabitosApi();
  final habitoDAO = HabitoDAO();
  final int usuarioId = 1;

  bool _carregando = true;
  List<Habito> _habitosUsuario = [];

  @override
  void initState() {
    super.initState();
    _carregarHabitos();
  }

  Future<void> _carregarHabitos() async {
    setState(() => _carregando = true);
    try {
      final habitos = await habitosApi.findAll();
      final habitosUsuario = habitos.where((h) => h.usuarioId == usuarioId).toList();

      if (habitosUsuario.isNotEmpty) {
        final ultimoHabito = habitosUsuario.last;
        final dados = jsonDecode(ultimoHabito.descricao);

        setState(() {
          aguaLitros = (dados['aguaLitros'] ?? 0.0).toDouble();
          horasSono = (dados['horasSono'] ?? 0.0).toDouble();
          nivelEstresse = (dados['nivelEstresse'] ?? 0.0).toDouble();
          tempoTela = (dados['tempoTela'] ?? 0.0).toDouble();
          tempoAoArLivre = (dados['tempoAoArLivre'] ?? 0.0).toDouble();
          nivelMotivacao = (dados['nivelMotivacao'] ?? 5.0).toDouble();

          meditou = dados['meditou'] ?? false;
          fezExercicio = dados['fezExercicio'] ?? false;
          alimentacaoSaudavel = dados['alimentacaoSaudavel'] ?? false;
          comeuFrutas = dados['comeuFrutas'] ?? false;
          leuLivro = dados['leuLivro'] ?? false;
          teveContatoSocial = dados['teveContatoSocial'] ?? false;

          autoAvaliacao = dados['autoAvaliacao'] ?? 3;
        });
      }

      setState(() {
        _habitosUsuario = habitosUsuario.reversed.toList();
      });
    } catch (e) {
      print('Erro ao carregar hábitos da API: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar hábitos.')),
      );
    } finally {
      setState(() => _carregando = false);
    }
  }

  Future<void> _salvarHabito() async {
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
          'autoAvaliacao': autoAvaliacao,
        }),
        data: now.toIso8601String(),
      );

      await habitoDAO.salvarHabito(habito);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hábito salvo com sucesso!')),
      );

      // Recarrega os hábitos para atualizar a lista
      _carregarHabitos();
    } catch (e) {
      print('Erro ao salvar hábito: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar hábito.')),
      );
    }
  }

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
  }) =>
      _card(
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

  Widget _checkboxHabit(String texto, bool valor, Function(bool?) onChanged) =>
      CheckboxListTile(
        title: Text(texto, style: const TextStyle(fontSize: 16)),
        value: valor,
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.purple,
      );

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
      body: _carregando
          ? const Center(child: CircularProgressIndicator(color: AppColors.purple))
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            _tituloSecao('Últimos Hábitos Registrados'),
            ..._habitosUsuario.map((habito) {
              final dados = jsonDecode(habito.descricao);
              return _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data: ${habito.data.split('T')[0]}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Água: ${dados['aguaLitros'] ?? 0} L'),
                    Text('Horas de Sono: ${dados['horasSono'] ?? 0} h'),
                    Text('Estresse: ${dados['nivelEstresse'] ?? 0}'),
                    Text('Motivação: ${dados['nivelMotivacao'] ?? 0}'),
                    Text('Tempo de Tela: ${dados['tempoTela'] ?? 0} h'),
                    Text('Tempo ao Ar Livre: ${dados['tempoAoArLivre'] ?? 0} h'),
                    Text('Meditou: ${dados['meditou'] == true ? "Sim" : "Não"}'),
                    Text('Fez Exercício: ${dados['fezExercicio'] == true ? "Sim" : "Não"}'),
                    Text('Alimentação Saudável: ${dados['alimentacaoSaudavel'] == true ? "Sim" : "Não"}'),
                    Text('Comeu Frutas: ${dados['comeuFrutas'] == true ? "Sim" : "Não"}'),
                    Text('Leu Livro: ${dados['leuLivro'] == true ? "Sim" : "Não"}'),
                    Text('Teve Contato Social: ${dados['teveContatoSocial'] == true ? "Sim" : "Não"}'),
                    Text('Autoavaliação: ${dados['autoAvaliacao'] ?? 0}'),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 24),
            _tituloSecao('Editar Último Hábito'),

            _sliderHabit(
                title: 'Consumo de Água',
                value: aguaLitros,
                min: 0,
                max: 5,
                divisions: 15,
                unidade: 'L',
                onChanged: (v) => setState(() => aguaLitros = v)),
            _sliderHabit(
                title: 'Horas de Sono',
                value: horasSono,
                min: 0,
                max: 15,
                divisions: 15,
                unidade: 'h',
                onChanged: (v) => setState(() => horasSono = v)),
            _sliderHabit(
                title: 'Estresse (0 a 10)',
                value: nivelEstresse,
                min: 0,
                max: 10,
                divisions: 10,
                unidade: '',
                onChanged: (v) => setState(() => nivelEstresse = v)),
            _sliderHabit(
                title: 'Motivação (0 a 10)',
                value: nivelMotivacao,
                min: 0,
                max: 10,
                divisions: 10,
                unidade: '',
                onChanged: (v) => setState(() => nivelMotivacao = v)),
            _sliderHabit(
                title: 'Tempo de Tela',
                value: tempoTela,
                min: 0,
                max: 20,
                divisions: 20,
                unidade: 'h',
                onChanged: (v) => setState(() => tempoTela = v)),
            _sliderHabit(
                title: 'Tempo ao Ar Livre',
                value: tempoAoArLivre,
                min: 0,
                max: 20,
                divisions: 20,
                unidade: 'h',
                onChanged: (v) => setState(() => tempoAoArLivre = v)),

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
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar')),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _salvarHabito();
                        },
                        child: const Text('Salvar',
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
