import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setUserStatus(bool status) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('LOGIN', status);
  }

  Future<bool> getUserStatus() async {
    final instance = await SharedPreferences.getInstance();
    final status = instance.getBool('LOGIN');
    return status ?? false;
  }
}
