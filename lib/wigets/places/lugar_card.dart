import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../pages/places/google_maps_page.dart';

class LugarCard extends StatefulWidget {
  final String titulo;
  final String telefone;
  final String endereco;
  final String imagem;
  final Color corPrimaria;
  final Color corSecundaria;

  const LugarCard({
    Key? key,
    required this.titulo,
    required this.telefone,
    required this.endereco,
    required this.imagem,
    required this.corPrimaria,
    required this.corSecundaria,
  }) : super(key: key);

  @override
  State<LugarCard> createState() => _LugarCardState();
}

class _LugarCardState extends State<LugarCard> {

  Future<void> _abrirMapa() async {
    try {
      List<Location> locations =
      await locationFromAddress(widget.endereco);

      if (locations.isNotEmpty) {
        final lat = locations[0].latitude;
        final lng = locations[0].longitude;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GoogleMapsPage(
              latLong: LatLng(lat, lng),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Local não encontrado!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao localizar endereço.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.corPrimaria, widget.corSecundaria],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: widget.corPrimaria.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGEM
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              widget.imagem,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),

          // CONTEÚDO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TÍTULO
                Text(
                  widget.titulo,
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // TELEFONE
                Row(
                  children: [
                    const Icon(Icons.phone, size: 18, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      widget.telefone,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // ENDEREÇO
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.white),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.endereco,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // BOTÃO MAPA
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: _mapButtonStyle(),
                      onPressed: _abrirMapa,
                      child: Text(
                        'Ver no mapa',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _mapButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: Colors.white.withOpacity(0.25),
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      overlayColor: Colors.white.withOpacity(0.15),
    );
  }
}
