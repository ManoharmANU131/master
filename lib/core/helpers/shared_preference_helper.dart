import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<void> setValue(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw ArgumentError("Unsupported type: ${value.runtimeType}");
    }
  }

  static Future<dynamic> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      final object = prefs.get(key);
      return object;
    }
    return null;
  }

  static void removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
