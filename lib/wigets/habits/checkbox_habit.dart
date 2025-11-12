import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class CheckboxHabit extends StatelessWidget {
  final String texto;
  final bool valor;
  final Function(bool?) onChanged;

  const CheckboxHabit({
    super.key,
    required this.texto,
    required this.valor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(texto, style: const TextStyle(fontSize: 16)),
      value: valor,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.purple,
    );
  }
}
