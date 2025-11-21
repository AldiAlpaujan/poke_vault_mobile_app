import 'package:shared_preferences/shared_preferences.dart';

class Session {
  final _userTokenKey = "AUTH-USER-TOKEN";

  Future<void> saveUserToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_userTokenKey, token);
  }

  Future<String> loadUserToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_userTokenKey) ?? '';
  }

  Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
  }
}
