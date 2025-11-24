import 'package:equilibreapp/model/user/user_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{
  late Usuario _user;

  Usuario get user => _user;

  setUser(Usuario user) {
    _user = user;
    notifyListeners();
  }
}