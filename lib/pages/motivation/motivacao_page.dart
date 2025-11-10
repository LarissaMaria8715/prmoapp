import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Importe a API e o Modelo
import '../../api/motivacao_api.dart';
import '../../model/quote_model.dart';
import '../../utils/colors.dart'; // Mantendo sua importação de cores

class MotivacaoPage extends StatefulWidget {
  const MotivacaoPage({super.key});

  @override
  State<MotivacaoPage> createState() => _MotivacaoPageState();
}

class _MotivacaoPageState extends State<MotivacaoPage> {
  // Inicialize a API
  final MotivacaoApi _api = MotivacaoApi();

  // Lista que armazenará todas as 50 citações (já traduzidas)
  List<Quote> _quotes = [];

  // Objeto a ser exibido
  // Inicializa com campos vazios, pois a frase será carregada assincronamente
  Quote _currentQuote = Quote(quote: '', author: '');

  // Controle de estado
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAndSortQuotes(); // Função principal de carregamento
  }

  // Novo método para buscar dados e sortear a primeira frase
  Future<void> _fetchAndSortQuotes() async {
    try {
      setState(() {
        _isLoading = true; // Inicia o carregamento
        _errorMessage = '';
      });

      // 1. Busca os quotes (e os traduz dentro da MotivacaoApi)
      _quotes = await _api.findQuotes();

      // 2. Sorteia o primeiro quote
      if (_quotes.isNotEmpty) {
        _sortearQuote();
      } else {
        // Isso só deve acontecer se a ZenQuotes não retornar nada
        _errorMessage = 'Nenhuma citação foi carregada.';
      }

    } catch (e) {
      // Trata erros de rede ou API
      _errorMessage = 'Falha ao carregar as citações. Tente novamente: ${e.toString()}';
      // Garante que o _currentQuote não seja nulo em caso de erro
      _currentQuote = Quote(quote: '...', author: '');
    } finally {
      // Para o indicador de carregamento
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Novo método para sortear uma quote da lista já carregada
  void _sortearQuote() {
    if (_quotes.isEmpty) return;

    final random = Random();
    setState(() {
      _currentQuote = _quotes[random.nextInt(_quotes.length)];
    });
  }

  // Widget auxiliar para exibir o estado atual (loading, erro ou citação)
  Widget _buildQuoteContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_errorMessage.isNotEmpty) {
      return Text(
        _errorMessage,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.red.shade700,
        ),
      );
    }

    // **PRINCIPAL AJUSTE:** Prioriza a citação traduzida
    final String textToDisplay = _currentQuote.translatedQuote.isNotEmpty
        ? _currentQuote.translatedQuote
        : _currentQuote.quote;

    // Mensagem padrão se a citação estiver vazia (só acontece se a API falhar ou estiver vazia)
    if (textToDisplay.isEmpty) {
      return Text(
        'Toque em "Nova Mensagem" para carregar uma frase.',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: AppColors.darkOrange5,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          // Exibe o texto traduzido ou original
          '"$textToDisplay"',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: AppColors.darkOrange5,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            // Exibe o autor
            '- ${_currentQuote.author}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkOrange4,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightOrange0,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.darkOrange4,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Motivação Diária', // Título em Português
            style: GoogleFonts.poppins(
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_emotions, size: 80, color: AppColors.darkOrange4),
              const SizedBox(height: 24),

              // Conteúdo da Citação / Indicador de Carregamento / Erro
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.lightOrange2.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkOrange4.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: _buildQuoteContent(), // Chamada ao método que exibe a tradução
              ),

              const SizedBox(height: 80),

              // Botão
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  // Botão desabilitado se estiver carregando ou com erro
                  onPressed: (_isLoading || _errorMessage.isNotEmpty) ? null : _sortearQuote,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    // Exibe "Carregando..." enquanto busca a API (e traduz)
                    _isLoading ? 'Carregando...' : 'Nova Mensagem',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkOrange5,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}