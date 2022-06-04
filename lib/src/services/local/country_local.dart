import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

initCountry() async {
  final SharedPreferences prefs = await _prefs;
  if (prefs.getBool('firstStart') == null) {
    await prefs.setString('country', 'USA');
  }
}
