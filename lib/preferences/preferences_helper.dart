import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyRestaurants = 'DAILY_RESTAURANTS';

  Future<bool> get isDailyRestaurantsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurants) ?? false;
  }

  void setDailyRestaurants(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurants, value);
  }
}
