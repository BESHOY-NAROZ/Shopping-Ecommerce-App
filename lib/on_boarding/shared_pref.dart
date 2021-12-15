import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefShop {
  static SharedPreferences sharedPreferences;

  static sharedDefinition() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putData(String key, dynamic value) async {
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      print('bool data puted');
    }
    if (value is String) {
      await sharedPreferences.setString(key, value);
      print('bool data puted');
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
  }

  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  static dynamic removeData(String key) {
    return sharedPreferences.remove(key);
  }
}
