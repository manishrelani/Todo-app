import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Model/User.dart';

class ShareManager {
  static Future setUserDetails(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  static Future<User> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email") ?? "";
    var password = prefs.getString("password") ?? "";
    return User(email: email, password: password);
  }

  static Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static Future<void> setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", true);
  }

  static Future<bool> getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }
}
