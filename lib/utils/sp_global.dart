


import 'package:shared_preferences/shared_preferences.dart';

class SpGlobal {
  
  static final SpGlobal _instance = SpGlobal._();
  SpGlobal._();

  factory SpGlobal(){
    return _instance;
  }

  late SharedPreferences _prefs;

  Future<void> initSharedPreferences()async {
    _prefs = await SharedPreferences.getInstance();
  }

  set token(String value ){

    _prefs.setString("token", value);

  }

  String get token {
    return _prefs.getString("token") ?? "";
  }

  

}