import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class User {
  final String account;
  final String name;
  final bool logined;

  User({this.account, this.name, this.logined: true}) : assert(account != null);
}

class UserStore {
  static Future<User> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String account = pref.getString("account");
    if (account != null && account.isNotEmpty)
      return new User(
          account: pref.getString("account"),
          name: pref.getString("name"),
          logined: pref.getBool("logined"));
    else
      return null;
  }

  static void saveUser(User u) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("account", u.account);
    pref.setString("name", u.name);
    pref.setBool("logined", u.logined);
  }

  static void loginOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("logined", false);
  }
}
