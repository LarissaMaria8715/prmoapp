import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../pages/places/google_maps_page.dart';
import '../../provider/favoritos_provider.dart';

class LugarCard extends StatelessWidget {
  final Lugar lugar;

  const LugarCard({Key? key, required this.lugar}) : super(key: key);

  Future<void> _abrirMapa(BuildContext context) async {
    try {
      List<Location> locations = await locationFromAddress(lugar.endereco);

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
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Local não encontrado!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Erro ao localizar endereço.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritosProvider = Provider.of<FavoritosProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lugar.corPrimaria, lugar.corSecundaria],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: lugar.corPrimaria.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGEM + FAVORITO
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  lugar.imagem,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    if (favoritosProvider.isFavorito(lugar)) {
                      favoritosProvider.removeFavorito(lugar);
                    } else {
                      favoritosProvider.addFavorito(lugar);
                    }
                  },
                  child: Consumer<FavoritosProvider>(
                    builder: (context, provider, _) {
                      final isFavorito = provider.isFavorito(lugar);
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorito ? Icons.favorite : Icons.favorite_border,
                          color: isFavorito ? Colors.redAccent : Colors.white,
                          size: 26,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // CONTEÚDO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lugar.titulo,
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 18, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      lugar.telefone,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.white),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        lugar.endereco,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: _mapButtonStyle(),
                      onPressed: () => _abrirMapa(context),
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
