import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setUserStatus(bool status) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('LOGIN', status);
  }

  Future<bool> getUserStatus() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool('LOGIN') ?? false;
  }

  Future<void> saveUserData(Map<String, dynamic> user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('USER_DATA', jsonEncode(user));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString('USER_DATA');
    if (data == null) return null;
    return jsonDecode(data);
  }

  Future<void> logout() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('LOGIN');
    await instance.remove('USER_DATA');
  }
}
