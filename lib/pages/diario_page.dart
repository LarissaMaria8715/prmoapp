import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class DiarioPage extends StatefulWidget {
  const DiarioPage({super.key});

  @override
  State<DiarioPage> createState() => _DiarioPageState();
}

class DiarioEntry {
  final String texto;
  final DateTime data;

  DiarioEntry({required this.texto, required this.data});
}

class _DiarioPageState extends State<DiarioPage> {
  final TextEditingController _controller = TextEditingController();
  final List<DiarioEntry> _entradas = [];
  bool _salvando = false;

  void _salvarEntrada() {
    if (_controller.text.trim().isEmpty) return;

    setState(() => _salvando = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _entradas.insert(
          0,
          DiarioEntry(texto: _controller.text.trim(), data: DateTime.now()),
        );
        _controller.clear();
        _salvando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Entrada salva com sucesso!")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: AppColors.darkRed3,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {},
          ),
          title: Text(
            'Diário Pessoal',
            style: GoogleFonts.lato(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Como foi seu dia?",
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkRed3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.darkRed3.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkRed3.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(2, 4),
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: AppColors.darkRed3,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Escreva aqui sobre seu dia...',
                            hintStyle: GoogleFonts.lato(
                              color: AppColors.darkRed3.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      flex: 3,
                      child: _entradas.isEmpty
                          ? Text(
                        'Nenhuma entrada ainda.',
                        style: GoogleFonts.lato(
                          color: AppColors.darkRed3.withOpacity(0.5),
                        ),
                      )
                          : ListView.builder(
                        itemCount: _entradas.length,
                        itemBuilder: (context, index) {
                          final entrada = _entradas[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.darkRed3.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.darkRed3.withOpacity(0.05),
                                  blurRadius: 3,
                                  offset: const Offset(1, 2),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entrada.texto,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(color: AppColors.darkRed3),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _formatarData(entrada.data),
                                  style: GoogleFonts.lato(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    color: AppColors.darkRed3.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _salvando ? null : _salvarEntrada,
                  icon: _salvando
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                      : const Icon(Icons.save, color: AppColors.white),
                  label: Text(
                    _salvando ? 'Salvando...' : 'Salvar Entrada',
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueDark,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }
}

