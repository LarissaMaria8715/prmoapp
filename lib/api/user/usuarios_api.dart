import 'package:dio/dio.dart';
import '../../model/user/user_model.dart';

class UsuariosApi {
  final dio = Dio();
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<List<Usuario>> findAll() async {
    List<Usuario> listaUsuarios = [];

    final response = await dio.get('$baseUrl/usuarios');

    if (response.statusCode == 200) {
      var listResult = response.data;
      for (var json in listResult) {
        Usuario usuario = Usuario.fromJson(json);
        listaUsuarios.add(usuario);
      }
    }

    await Future.delayed(Duration(seconds: 2));

    return listaUsuarios;
  }
}
