import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class ImagemComMoldura extends StatelessWidget {
  final String imagemUrl;

  const ImagemComMoldura({Key? key, required this.imagemUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightWine1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.wine, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkWine1.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imagemUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      ),
    );
  }
}
