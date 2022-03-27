import 'dart:io';
class SharedPref {
  final data = {};
  final prefs;
  SharedPref({this.prefs});
  bool get isDesktop =>  Platform.isFuchsia || Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  get(String key)  {
    if (isDesktop) {
      return data[key];
    }

    return ( prefs).get(key);
  }

  Set<String> getKeys()  {
    if (isDesktop) {
      return data.keys;
    }

    return ( prefs).getKeys();
  }

  List<String> getStringList(String key)  {
    if (isDesktop) {
      return get(key);
    }

    return ( prefs).getStringList(key);
  }

  bool setBool(String key, bool value)  {
    if (isDesktop) {
      data[key] = value;
      return true;
    }

    return ( prefs).setBool(key, value);
  }

  bool setDouble(String key, double value)  {
    if (isDesktop) {
      data[key] = value;
      return true;
    }

    return ( prefs).setDouble(key, value);
  }

  boolsetInt(String key, int value)  {
    if (isDesktop) {
      data[key] = value;
      return true;
    }

    return ( prefs).setInt(key, value);
  }

  bool setString(String key, String value)  {
    if (isDesktop) {
      data[key] = value;
      return true;
    }

    return (prefs).setString(key, value);
  }

  bool setStringList(String key, List<String> value)  {
    if (isDesktop) {
      data[key] = value;
      return true;
    }

    return ( prefs).setStringList(key, value);
  }
}
