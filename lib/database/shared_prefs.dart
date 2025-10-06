
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  void setUserStatus(bool status) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setBool('LOGIN', status);
  }

  Future<bool> getUserStatus() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    bool? status = instance.getBool('LOGIN');

    // Opcao 1
    // if (status == null) {
    //   return false;
    // } else {
    //   return status;
    // }

    // Opcao 2
    return status ?? false;
  }
}