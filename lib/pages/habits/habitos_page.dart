import 'dart:convert';
import 'package:flutter/material.dart';
import '../../database/habito_dao.dart';
import '../../model/habito_model.dart';
import '../../utils/colors.dart';
import '../../wigets/card_container.dart';
import '../../wigets/checkbox_habit.dart';
import '../../wigets/dropdown_autoavaliacao.dart';
import '../../wigets/slider_habit_widget.dart';
import '../../wigets/titulo_secao_widget.dart';
import '../../api/habitos_api.dart';

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

  final habitoDAO = HabitoDAO();
  final int usuarioId = 1;

  bool _carregando = true;
  bool _salvando = false;
  List<Habito> _habitosUsuario = [];

  @override
  void initState() {
    super.initState();
    _carregarHabitos();
  }
  Future<void> _carregarHabitos() async {
    setState(() => _carregando = true);

    try {
      final api = HabitosApi();

      final habitosLocal = await habitoDAO.listarHabitos(usuarioId);

      final habitosApi = await api.findAll();
      final habitosDoUsuarioApi =
      habitosApi.where((h) => h.usuarioId == usuarioId).toList();

      for (final habitoApi in habitosDoUsuarioApi) {
        final existe = await habitoDAO.existeHabitoComId(habitoApi.id ?? -1);
        if (!existe) {
          await habitoDAO.inserirHabito(habitoApi);
        }
      }

      final todos = await habitoDAO.listarHabitos(usuarioId);

      todos.sort((a, b) => b.data.compareTo(a.data));

      setState(() => _habitosUsuario = todos);
    } catch (e) {
      print(' Erro ao carregar hábitos: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Erro ao carregar hábitos.')));
    } finally {
      setState(() => _carregando = false);
    }
  }

  Future<void> _salvarHabito() async {
    setState(() => _salvando = true);

    try {
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
        data: DateTime.now().toIso8601String(),
      );

      await habitoDAO.inserirHabito(habito);

      setState(() {
        _habitosUsuario.insert(0, habito);
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(' Hábito salvo!')));
    } catch (e) {
      print(' Erro ao salvar hábito: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Erro ao salvar hábito.')));
    } finally {
      setState(() => _salvando = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    bool boolOrFalse(dynamic valor) => valor == true;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.purple,
            toolbarHeight: 80,
            title: const Text(
              'Meus Hábitos Diários',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                const TituloSecao('Editar Último Hábito'),

                // Sliders
                SliderHabit(
                  title: 'Consumo de Água',
                  value: aguaLitros,
                  min: 0,
                  max: 5,
                  divisions: 15,
                  unidade: 'L',
                  onChanged: (v) => setState(() => aguaLitros = v),
                ),
                SliderHabit(
                  title: 'Horas de Sono',
                  value: horasSono,
                  min: 0,
                  max: 15,
                  divisions: 15,
                  unidade: 'h',
                  onChanged: (v) => setState(() => horasSono = v),
                ),
                SliderHabit(
                  title: 'Estresse (0 a 10)',
                  value: nivelEstresse,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  unidade: '',
                  onChanged: (v) => setState(() => nivelEstresse = v),
                ),
                SliderHabit(
                  title: 'Motivação (0 a 10)',
                  value: nivelMotivacao,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  unidade: '',
                  onChanged: (v) => setState(() => nivelMotivacao = v),
                ),
                SliderHabit(
                  title: 'Tempo de Tela',
                  value: tempoTela,
                  min: 0,
                  max: 20,
                  divisions: 20,
                  unidade: 'h',
                  onChanged: (v) => setState(() => tempoTela = v),
                ),
                SliderHabit(
                  title: 'Tempo ao Ar Livre',
                  value: tempoAoArLivre,
                  min: 0,
                  max: 20,
                  divisions: 20,
                  unidade: 'h',
                  onChanged: (v) => setState(() => tempoAoArLivre = v),
                ),

                // Checkboxes
                const TituloSecao('Hábitos Binários'),
                CardContainer(
                  child: Column(
                    children: [
                      CheckboxHabit(
                        texto: 'Meditou hoje?',
                        valor: meditou,
                        onChanged: (v) => setState(() => meditou = v ?? false),
                      ),
                      CheckboxHabit(
                        texto: 'Fez exercícios físicos?',
                        valor: fezExercicio,
                        onChanged: (v) => setState(() => fezExercicio = v ?? false),
                      ),
                      CheckboxHabit(
                        texto: 'Alimentação saudável?',
                        valor: alimentacaoSaudavel,
                        onChanged: (v) => setState(() => alimentacaoSaudavel = v ?? false),
                      ),
                      CheckboxHabit(
                        texto: 'Comeu frutas?',
                        valor: comeuFrutas,
                        onChanged: (v) => setState(() => comeuFrutas = v ?? false),
                      ),
                      CheckboxHabit(
                        texto: 'Leu algum livro?',
                        valor: leuLivro,
                        onChanged: (v) => setState(() => leuLivro = v ?? false),
                      ),
                      CheckboxHabit(
                        texto: 'Teve contato social?',
                        valor: teveContatoSocial,
                        onChanged: (v) => setState(() => teveContatoSocial = v ?? false),
                      ),
                    ],
                  ),
                ),

                const TituloSecao('Autoavaliação do Dia'),
                DropdownAutoavaliacao(
                  valor: autoAvaliacao,
                  onChanged: (v) => setState(() => autoAvaliacao = v!),
                ),

                const SizedBox(height: 24),

                // Botão salvar
                ElevatedButton.icon(
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
                    builder: (_) => AlertDialog(
                      title: const Text('Salvar hábitos'),
                      content: const Text('Deseja salvar os hábitos de hoje?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _salvarHabito();
                          },
                          child: const Text(
                            'Salvar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Lista de hábitos salvos
                const TituloSecao('Hábitos Salvos'),
                ..._habitosUsuario.map((habito) {
                  final dados = jsonDecode(habito.descricao);
                  return CardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📅 Data: ${habito.data.split("T")[0]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Água: ${dados['aguaLitros'] ?? 0} L'),
                        Text('Sono: ${dados['horasSono'] ?? 0} h'),
                        Text('Estresse: ${dados['nivelEstresse'] ?? 0}'),
                        Text('Motivação: ${dados['nivelMotivacao'] ?? 0}'),
                        Text('Tela: ${dados['tempoTela'] ?? 0} h'),
                        Text('Ar Livre: ${dados['tempoAoArLivre'] ?? 0} h'),
                        Text('Meditou: ${boolOrFalse(dados['meditou']) ? "Sim" : "Não"}'),
                        Text('Exercício: ${boolOrFalse(dados['fezExercicio']) ? "Sim" : "Não"}'),
                        Text('Alimentação: ${boolOrFalse(dados['alimentacaoSaudavel']) ? "Sim" : "Não"}'),
                        Text('Frutas: ${boolOrFalse(dados['comeuFrutas']) ? "Sim" : "Não"}'),
                        Text('Leu Livro: ${boolOrFalse(dados['leuLivro']) ? "Sim" : "Não"}'),
                        Text('Contato Social: ${boolOrFalse(dados['teveContatoSocial']) ? "Sim" : "Não"}'),
                        Text('Autoavaliação: ${dados['autoAvaliacao'] ?? 0}'),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        if (_carregando || _salvando)
          Container(
            color: Colors.white.withOpacity(0.7),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.purple),
            ),
          ),
      ],
    );
  }
}
