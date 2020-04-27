
import 'package:flutter/widgets.dart';

class AuthNotifier with ChangeNotifier {
  String _user;


  String get user => _user;

  void setUser(String user) {
    _user = user;
    notifyListeners();
  }
  
}