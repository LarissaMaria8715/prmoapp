import 'package:flutter/material.dart';
import '../model/places/lugar/lugar.dart';

class FavoritosProvider with ChangeNotifier {
  final List<Lugar> _favoritos = [];

  List<Lugar> get favoritos => _favoritos;

  void addFavorito(Lugar lugar) {
    if (!_favoritos.contains(lugar)) {
      _favoritos.add(lugar);
      notifyListeners();
    }
  }

  void removeFavorito(Lugar lugar) {
    _favoritos.remove(lugar);
    notifyListeners();
  }

  bool isFavorito(Lugar lugar) {
    return _favoritos.contains(lugar);
  }
}
