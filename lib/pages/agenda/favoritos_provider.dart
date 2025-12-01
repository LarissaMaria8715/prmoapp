import 'package:flutter/material.dart';

class Lugar {
  final String titulo;
  final String telefone;
  final String endereco;
  final String imagem;
  final Color corPrimaria;
  final Color corSecundaria;

  Lugar({
    required this.titulo,
    required this.telefone,
    required this.endereco,
    required this.imagem,
    required this.corPrimaria,
    required this.corSecundaria,
  });

  // Para comparação e evitar duplicatas
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Lugar &&
              runtimeType == other.runtimeType &&
              titulo == other.titulo &&
              endereco == other.endereco;

  @override
  int get hashCode => titulo.hashCode ^ endereco.hashCode;
}

class FavoritosProvider extends ChangeNotifier {
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
