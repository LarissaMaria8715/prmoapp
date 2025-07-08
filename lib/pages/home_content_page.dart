import 'package:equilibreapp/pages/humor_page.dart';
import 'package:equilibreapp/wigets/style_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      children: [
        _actionButtonsGrid(),
      ],
    );
  }

   _actionButtonsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _actionButton(
                Icons.sentiment_satisfied_alt,
                'Humor',
                AppColors.lightBlueDark4,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HumorPage()),
                  );
                },
              )),
              const SizedBox(width: 30),
              Expanded(child: _actionButton(
                Icons.water_drop,
                'Hábitos',
                AppColors.darkPurple3,
                    () {
                  print('Botão Hábitos clicado');
                },
              )),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(child: _actionButton(
                Icons.self_improvement,
                'Respiração',
                AppColors.darkGreen3,
                    () {
                  print('Botão Respiração clicado');
                },
              )),
              const SizedBox(width: 30),
              Expanded(child: _actionButton(
                Icons.track_changes,
                'Metas',
                AppColors.darkYellow3,
                    () {
                  print('Botão Metas clicado');
                },
              )),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(child: _actionButton(
                Icons.menu_book,
                'Diário',
                AppColors.darkRed3,
                    () {
                  print('Botão Diário clicado');
                },
              )),
              const SizedBox(width: 30),
              Expanded(child: _actionButton(
                Icons.rocket_launch,
                'Motivação',
                AppColors.darkOrange2,
                    () {
                  print('Botão Motivação clicado');
                },
              )),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(child: _actionButton(
                Icons.calendar_month_outlined,
                'Agenda',
                AppColors.darkBordeaux3,
                    () {
                  print('Botão Agenda clicado');
                },
              )),
              const SizedBox(width: 30),
              Expanded(child: Container()),
            ],
          ),
        ],

      ),
    );
  }

   _actionButton(IconData icon, String label, Color backgroundColor, VoidCallback onPressed) {
    return StyleButton(
      icon: icon,
      label: label,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
    );
  }
}
