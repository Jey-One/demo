import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late SharedPreferences _sharedPreferences;

  Future<dynamic> getData(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.get(key);
  }

  Future<void> setData(String key, String value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(key, value);
  }
}
