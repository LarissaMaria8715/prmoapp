import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/book/livro_model.dart';
import '../../utils/colors.dart';

class LivroCard extends StatelessWidget {
  final Livro livro;
  const LivroCard({super.key, required this.livro});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBrown4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      shadowColor: Colors.brown.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(livro.capaUrl, height: 300, width: double.infinity, fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Image.network('https://slgembalagens.com.br/wp-content/uploads/woocommerce-placeholder-300x300.png', height: 300, width: double.infinity, fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  livro.titulo,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightBrown1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  livro.autor,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
