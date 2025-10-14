import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'card_container.dart';

class SliderHabit extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String unidade;
  final Function(double) onChanged;

  const SliderHabit({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.unidade,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: '${value.toStringAsFixed(1)} $unidade',
            activeColor: AppColors.purple,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
