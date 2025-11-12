import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../card_container.dart';

class DropdownAutoavaliacao extends StatelessWidget {
  final int valor;
  final Function(int?) onChanged;

  const DropdownAutoavaliacao({
    super.key,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: DropdownButtonFormField<int>(
        value: valor,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        items: List.generate(5, (i) {
          final label = ['Péssimo', 'Ruim', 'Regular', 'Bom', 'Excelente'][i];
          return DropdownMenuItem(
              value: i + 1, child: Text('${i + 1} - $label'));
        }),
        onChanged: onChanged,
      ),
    );
  }
}
