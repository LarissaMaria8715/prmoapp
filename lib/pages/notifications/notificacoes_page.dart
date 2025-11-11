import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class NotificacoesPage extends StatelessWidget {
  const NotificacoesPage({super.key});

  // Lista de notificações fictícias
  final List<String> notificacoes = const [
    "Você tem uma nova meta para hoje!",
    "Não se esqueça de registrar seus hábitos.",
    "Nova mensagem de motivação disponível.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificações',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.lightBlue2,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: notificacoes.isEmpty
            ? Center(
          child: Text(
            'Nenhuma notificação no momento',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          itemCount: notificacoes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // ação ao tocar na notificação (opcional)
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: Colors.black26,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue2.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: AppColors.lightBlue2,
                      ),
                    ),
                    title: Text(
                      notificacoes[index],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
