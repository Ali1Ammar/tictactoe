import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final data = {};
  final SharedPreferences prefs;
  SharedPref({required this.prefs});
  Object? get(String key) {
    return (prefs).get(key);
  }

  Set<String> getKeys() {
    return prefs.getKeys();
  }

  List<String> getStringList(String key) {
    return (prefs).getStringList(key) ?? [];
  }

  void setBool(String key, bool value) {
    (prefs).setBool(key, value);
  }

  void setDouble(String key, double value) {
    (prefs).setDouble(key, value);
  }

  void setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  void setString(String key, String value) {
    (prefs).setString(key, value);
  }

  void setStringList(String key, List<String> value) {
    (prefs).setStringList(key, value);
  }
}
