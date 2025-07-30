import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class ResumoPage extends StatelessWidget {
  const ResumoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSecao("Consumo de Água", _graficoBarras()),
            _buildSecao("Horas de Sono", _graficoLinhas()),
            _buildSecao("Hábitos Saudáveis", _graficoPizza()),
            _buildSecao("Motivação Média", _graficoCircular()),
            _buildSecao("Resumo de Humor", _graficoHumor()),
          ],
        ),
      ),
    );
  }

  Widget _buildSecao(String titulo, Widget grafico) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              titulo,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBordeaux4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            grafico,
          ],
        ),
      ),
    );
  }

  Widget _graficoBarras() {
    return SizedBox(
      height: 320,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final dias = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
                  return Text(dias[value.toInt()], style: TextStyle(fontSize: 12));
                },
              ),
            ),
          ),
          barGroups: List.generate(7, (i) {
            return BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: 1.5 + i * 0.2,
                color: AppColors.bordeaux,
                width: 18,
                borderRadius: BorderRadius.circular(4),
              )
            ]);
          }),
        ),
      ),
    );
  }

  Widget _graficoLinhas() {
    return SizedBox(
      height: 320,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final dias = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
                  return Text(dias[value.toInt()], style: TextStyle(fontSize: 12));
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: AppColors.darkGreen3,
              spots: [
                FlSpot(0, 6),
                FlSpot(1, 7),
                FlSpot(2, 6.5),
                FlSpot(3, 5),
                FlSpot(4, 7.5),
                FlSpot(5, 8),
                FlSpot(6, 6.8),
              ],
              belowBarData: BarAreaData(show: true, color: AppColors.darkGreen3.withOpacity(0.2)),
              dotData: FlDotData(show: true),
            )
          ],
        ),
      ),
    );
  }

  Widget _graficoPizza() {
    return SizedBox(
      height: 320,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 50,
          sections: [
            PieChartSectionData(
              value: 30,
              color: AppColors.darkGreen2,
              title: 'Exercícios',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
            PieChartSectionData(
              value: 25,
              color: AppColors.bordeaux,
              title: 'Sono',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
            PieChartSectionData(
              value: 20,
              color: AppColors.darkBordeaux4,
              title: 'Leitura',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
            PieChartSectionData(
              value: 25,
              color: AppColors.lightGreen3,
              title: 'Meditação',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _graficoCircular() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    backgroundColor: Colors.grey[300],
                    color: AppColors.darkGreen3,
                    strokeWidth: 38,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Motivação",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.darkGreen3,
                      ),
                    ),
                    Text(
                      "75%",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _graficoHumor() {
    return SizedBox(
      height: 320,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 50,
          sections: [
            PieChartSectionData(
              value: 40,
              color: AppColors.blue,
              title: 'Feliz',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
            PieChartSectionData(
              value: 30,
              color: AppColors.bordeaux,
              title: 'Neutro',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
            PieChartSectionData(
              value: 30,
              color: Colors.grey,
              title: 'Triste',
              radius: 80,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
