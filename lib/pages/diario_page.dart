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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Como foi seu dia?",
              style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 16),

            // Campo de texto
            Expanded(
              flex: 2,
              child: TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: GoogleFonts.lato(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Escreva aqui sobre seu dia...',
                  hintStyle: GoogleFonts.lato(color: AppColors.accent.withOpacity(0.5)),
                  filled: true,
                  fillColor: AppColors.accent.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.accent, width: 1),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Botão de salvar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _salvando ? null : _salvarEntrada,
                icon: _salvando
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
                )
                    : const Icon(Icons.save, color: AppColors.white),
                label: Text(
                  _salvando ? "Salvando..." : "Salvar Entrada",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Lista de entradas
            Expanded(
              flex: 3,
              child: _entradas.isEmpty
                  ? Text(
                'Nenhuma entrada ainda.',
                style: GoogleFonts.lato(color: AppColors.accent.withOpacity(0.5)),
              )
                  : ListView.builder(
                itemCount: _entradas.length,
                itemBuilder: (context, index) {
                  final entrada = _entradas[index];
                  return Card(
                    color: AppColors.accent.withOpacity(0.08),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        entrada.texto,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(),
                      ),
                      subtitle: Text(
                        _formatarData(entrada.data),
                        style: GoogleFonts.lato(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year;
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');
    return '$dia/$mes/$ano às $hora:$minuto';
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      backgroundColor: AppColors.accent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Diário Pessoal',
        style: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}
