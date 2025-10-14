import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/diario_api.dart';
import '../model/diario_model.dart';
import '../database/diario_dao.dart';
import '../utils/colors.dart';

class DiarioPage extends StatefulWidget {
  const DiarioPage({super.key});

  @override
  State<DiarioPage> createState() => _DiarioPageState();
}

class _DiarioPageState extends State<DiarioPage> {
  final TextEditingController _textoController = TextEditingController();
  final DiarioDAO diarioDAO = DiarioDAO();
  final DiarioApi _api = DiarioApi();

  List<Diario> entradasDiario = [];
  bool _isLoading = false; //  indicador de carregamento
  final int usuarioId = 1;

  @override
  void initState() {
    super.initState();
    _carregarEntradas();
  }

  Future<void> _carregarEntradas() async {
    setState(() => _isLoading = true); // inicia o loading
    try {
      final dadosLocais = await diarioDAO.listarPorUsuario(usuarioId);
      final dadosApi = await _api.findAll();

      setState(() {
        print('Dados liquidos da API: ${dadosApi}');
        entradasDiario = [...dadosApi, ...dadosLocais, ...dadosLocais];
      });
    } catch (e) {
      print('Erro ao carregar entradas: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar entradas.')),
      );
    } finally {
      setState(() => _isLoading = false); // encerra o loading
    }
  }

  Future<void> _salvarEntrada() async {
    final texto = _textoController.text.trim();
    if (texto.isEmpty) return;

    final novaEntrada = Diario(
      usuarioId: usuarioId,
      titulo: '',
      conteudo: texto,
      data: DateTime.now().toIso8601String(),
    );

    try {
      await diarioDAO.salvar(novaEntrada);
      _textoController.clear();
      await _carregarEntradas();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Entrada salva no diário!')),
      );
    } catch (e) {
      print('Erro ao salvar entrada: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar entrada.')),
      );
    }
  }

  @override
  void dispose() {
    _textoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightRed1,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.darkRed4,
          title: Text(
            'Diário Pessoal',
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _isLoading
            ? const Center(
          // ✅ símbolo de carregando
          child: CircularProgressIndicator(
            color: AppColors.darkRed5,
            strokeWidth: 4,
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Como você está se sentindo hoje?',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: AppColors.darkRed5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _textoController,
                maxLines: 6,
                style: const TextStyle(color: AppColors.darkRed5),
                decoration: InputDecoration(
                  hintText: 'Escreva aqui...',
                  hintStyle: const TextStyle(color: AppColors.darkRed5),
                  filled: true,
                  fillColor: AppColors.lightRed4.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _salvarEntrada,
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Salvar Entrada',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkRed5,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Entradas Anteriores',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: AppColors.darkRed5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: entradasDiario.isEmpty
                    ? const Center(
                  child: Text(
                    'Nenhuma entrada ainda.',
                    style: TextStyle(color: AppColors.darkRed5),
                  ),
                )
                    : ListView.builder(
                  itemCount: entradasDiario.length,
                  itemBuilder: (context, index) {
                    final entrada = entradasDiario[index];
                    return Card(
                      color: AppColors.lightRed2.withOpacity(0.3),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              entrada.data.substring(0, 10),
                              style: const TextStyle(
                                color: AppColors.darkRed5,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              entrada.conteudo,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
