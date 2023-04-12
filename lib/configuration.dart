import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class Configuration {
  late SharedPreferences _preferences;
  late String _databasePath;

  Configuration._internal();

  static Future<Configuration> getInstance() async {
    Configuration config = Configuration._internal();

    config._preferences = await SharedPreferences.getInstance();
    config._databasePath = config._preferences.getString("databasePath") ??
        p.join((await getApplicationDocumentsDirectory()).path, "ax023.db");

    return config;
  }

  String get databasePath => _databasePath;

  set databasePath(String value) {
    _databasePath = value;
    _preferences.setString("databasePath", value);
  }
}
