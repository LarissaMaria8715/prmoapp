// lib/model/quote_model.dart

class Quote {
  final String quote; // c: citation (citação)
  final String author; // a: autor
  // Novo campo para a tradução
  String translatedQuote = ''; // Inicializado como vazio
  Quote({required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      // A API ZenQuotes usa 'q' para quote e 'a' para author
      quote: json['q'] ?? 'Quote not available',
      author: json['a'] ?? 'Unknown Author',
    );
  }
}