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
}
