import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  get userId => null;

  Future<void> setUserID(int userID) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt('USER_ID', userID);
  }

  Future<int> getUserId() async {
    final instance = await SharedPreferences.getInstance();
    int? userID = instance.getInt('USER_ID') ;
    return userId ?? 0;
  }


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
