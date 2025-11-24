import 'package:dio/dio.dart';
import '../../model/user/user_model.dart';

class UsuariosApi {
  final dio = Dio();
  final String baseUrl = 'https://my-json-server.typicode.com/LarissaMaria8715/equilibre-api';

  Future<Usuario?> login(String email, String senha) async {
    final loginResponse = await dio.get('$baseUrl/login');
    if (loginResponse.statusCode == 200) {
      final List logins = loginResponse.data;
      final match = logins.firstWhere(
            (l) => l['email'] == email && l['senha'] == senha,
        orElse: () => null,
      );

      if (match != null) {
        final userResponse =
        await dio.get('$baseUrl/usuarios/${match['usuarioId']}');
        return Usuario.fromJson(userResponse.data);
      }
    }
    //throw Exception('Usuário não encontrado!');
    return null;
  }
}